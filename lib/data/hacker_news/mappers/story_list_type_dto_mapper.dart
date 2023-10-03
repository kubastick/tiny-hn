import 'package:injectable/injectable.dart';
import 'package:tiny_hn/data/common/bidirectional_data_mapper.dart';
import 'package:tiny_hn/data/hacker_news/dtos/story_list_type_dto.dart';
import 'package:tiny_hn/domain/hacker_news/models/story_list_type.dart';

@injectable
class StoryListTypeDTOMapper implements BiDirectionalDataMapper<StoryListType, StoryListTypeDTO> {
  @override
  StoryListType from(StoryListTypeDTO data) {
    return switch (data) {
      StoryListTypeDTO.newest => StoryListType.newest,
      StoryListTypeDTO.top => StoryListType.top,
      StoryListTypeDTO.best => StoryListType.best,
    };
  }

  @override
  StoryListTypeDTO to(StoryListType data) {
    return switch (data) {
      StoryListType.newest => StoryListTypeDTO.newest,
      StoryListType.top => StoryListTypeDTO.top,
      StoryListType.best => StoryListTypeDTO.best,
    };
  }
}
