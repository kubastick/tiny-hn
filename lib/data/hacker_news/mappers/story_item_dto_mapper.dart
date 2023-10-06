import 'package:injectable/injectable.dart';
import 'package:tiny_hn/data/common/bidirectional_data_mapper.dart';
import 'package:tiny_hn/data/hacker_news/dtos/item_dto.dart';
import 'package:tiny_hn/domain/hacker_news/models/story.dart';

@injectable
class StoryItemDTOMapper implements BiDirectionalDataMapper<Story, ItemDTO> {
  @override
  Story from(ItemDTO data) {
    return Story(
      id: data.id.toString(),
      authorUsername: data.by ?? 'Unknown',
      commentCount: data.descendants ?? 0,
      commentIDs: data.kids ?? [],
      score: data.score ?? 0,
      creationTime: DateTime.fromMillisecondsSinceEpoch(data.time),
      title: data.title ?? '',
      url: data.url,
    );
  }

  @override
  ItemDTO to(Story data) {
    // TODO(jakubtomana): implement to
    throw UnimplementedError();
  }
}
