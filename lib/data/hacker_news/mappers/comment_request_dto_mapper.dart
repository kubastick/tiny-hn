import 'package:injectable/injectable.dart';
import 'package:tiny_hn/data/common/bidirectional_data_mapper.dart';
import 'package:tiny_hn/data/hacker_news/dtos/item_dto.dart';
import 'package:tiny_hn/domain/hacker_news/models/comment.dart';

@injectable
class CommentRequestDTOMapper implements BiDirectionalDataMapper<Comment, ItemDTO> {
  @override
  Comment from(ItemDTO data) {
    return Comment(
      id: data.id.toString(),
      author: data.by ?? '',
      creationDate: DateTime.fromMillisecondsSinceEpoch(data.time),
      text: data.text ?? '',
    );
  }

  @override
  ItemDTO to(Comment data) {
    // TODO(jakubtomana): implement to
    throw UnimplementedError();
  }
}
