import 'package:injectable/injectable.dart';
import 'package:tiny_hn/data/hacker_news/data_sources/hacker_news_data_source.dart';
import 'package:tiny_hn/data/hacker_news/dtos/item_dto.dart';
import 'package:tiny_hn/data/hacker_news/mappers/comment_request_dto_mapper.dart';
import 'package:tiny_hn/data/hacker_news/mappers/story_item_dto_mapper.dart';
import 'package:tiny_hn/data/hacker_news/mappers/story_list_type_dto_mapper.dart';
import 'package:tiny_hn/domain/hacker_news/hacker_news_repository.dart';
import 'package:tiny_hn/domain/hacker_news/models/comment.dart';
import 'package:tiny_hn/domain/hacker_news/models/story.dart';
import 'package:tiny_hn/domain/hacker_news/models/story_list_type.dart';

@Injectable(as: HackerNewsRepository)
class HackerNewsRepositoryImpl implements HackerNewsRepository {
  const HackerNewsRepositoryImpl(
    this._hackerNewsDataSource,
    this._storyItemDTOMapper,
    this._storyListTypeDTOMapper,
    this._commentRequestDTOMapper,
  );

  final HackerNewsDataSource _hackerNewsDataSource;
  final StoryItemDTOMapper _storyItemDTOMapper;
  final StoryListTypeDTOMapper _storyListTypeDTOMapper;
  final CommentRequestDTOMapper _commentRequestDTOMapper;

  @override
  Future<List<Story>> fetchStories({
    required StoryListType storyListType,
    required int from,
    required int count,
  }) async {
    final storyListTypeDTO = _storyListTypeDTOMapper.to(storyListType);

    final storyIDListResponse = await _hackerNewsDataSource.getStoriesFromCategory(
      categoryKey: storyListTypeDTO.categoryKey,
    );

    final storyIDList = storyIDListResponse.body;
    if (storyIDListResponse.error == null && storyIDList != null) {
      final validListRange = 0 <= from && from <= storyIDList.length;
      if (!validListRange) {
        throw RangeError.range(from, 0, storyIDList.length);
      }

      final storiesIterator = storyIDList.sublist(from).take(count);
      final storiesFuture = storiesIterator.map((storyID) => _fetchStory(storyID: storyID.toString()));
      final stories = await Future.wait(storiesFuture);

      return stories;
    } else {
      throw Exception(storyIDListResponse.error);
    }
  }

  @override
  Future<List<Story>?> getCachedStories() {
    // TODO(jakubtomana): implement getCachedStories
    throw UnimplementedError();
  }

  Future<Story> _fetchStory({required String storyID}) async {
    final storyItemDTO = await _fetchItemDTO(id: storyID);

    return _storyItemDTOMapper.from(storyItemDTO);
  }

  @override
  Future<List<Comment>> fetchStoryComments({required String storyID}) async {
    final story = await _fetchStory(storyID: storyID);
    final commentTree = await _getItemsTree(ids: story.commentIDs.map((id) => id.toString()));

    return _commentsFromTree(commentTree);
  }

  List<Comment> _commentsFromTree(List<_Tree<ItemDTO>> tree) {
    return tree
        .map(
          (treeItem) => _commentRequestDTOMapper.from(treeItem.item).copyWith(
                childComments: _commentsFromTree(treeItem.nodes),
              ),
        )
        .toList();
  }

  Future<List<_Tree<ItemDTO>>> _getItemsTree({required Iterable<String> ids}) async {
    final items = await Future.wait(
      ids.map(
        (id) => _fetchItemDTO(id: id),
      ),
    );

    final treeItems = <_Tree<ItemDTO>>[];
    for (final item in items) {
      final itemKids = item.kids;
      if (itemKids != null && itemKids.isNotEmpty) {
        treeItems.add(
          _Tree<ItemDTO>(
            item: item,
            nodes: await _getItemsTree(ids: itemKids.map((id) => id.toString())),
          ),
        );
      }
    }

    return treeItems;
  }

  Future<ItemDTO> _fetchItemDTO({required String id}) async {
    final request = await _hackerNewsDataSource.getItem(id: id);
    final requestBody = request.body;
    if (requestBody != null && request.error == null) {
      final itemDTO = ItemDTO.fromJson(requestBody);

      return itemDTO;
    } else {
      throw Exception(request.error);
    }
  }
}

class _Tree<T> {
  _Tree({
    required this.item,
    required this.nodes,
  });

  final T item;
  final List<_Tree<T>> nodes;
}
