import 'package:injectable/injectable.dart';
import 'package:tiny_hn/data/hacker_news/data_sources/hacker_news_data_source.dart';
import 'package:tiny_hn/data/hacker_news/dtos/item_dto.dart';
import 'package:tiny_hn/data/hacker_news/mappers/story_item_dto_mapper.dart';
import 'package:tiny_hn/data/hacker_news/mappers/story_list_type_dto_mapper.dart';
import 'package:tiny_hn/domain/hacker_news/hacker_news_repository.dart';
import 'package:tiny_hn/domain/hacker_news/models/story.dart';
import 'package:tiny_hn/domain/hacker_news/models/story_list_type.dart';

@Injectable(as: HackerNewsRepository)
class HackerNewsRepositoryImpl implements HackerNewsRepository {
  const HackerNewsRepositoryImpl(
    this._hackerNewsDataSource,
    this._storyItemDTOMapper,
    this._storyListTypeDTOMapper,
  );

  final HackerNewsDataSource _hackerNewsDataSource;
  final StoryItemDTOMapper _storyItemDTOMapper;
  final StoryListTypeDTOMapper _storyListTypeDTOMapper;

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
      final itemRequestFutures = storiesIterator.map((storyID) => _hackerNewsDataSource.getItem(id: storyID));
      final itemRequests = await Future.wait(itemRequestFutures);

      final stories = <Story>[];
      for (final request in itemRequests) {
        final requestBody = request.body;
        if (request.error == null && requestBody != null) {
          final itemDTO = ItemDTO.fromJson(requestBody);
          stories.add(_storyItemDTOMapper.from(itemDTO));
        }
      }

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
}
