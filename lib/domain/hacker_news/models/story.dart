import 'package:freezed_annotation/freezed_annotation.dart';

part 'story.freezed.dart';

@freezed
class Story with _$Story {
  const factory Story({
    required String id,
    required String authorUsername,
    required int commentCount,
    required List<int> commentIDs,
    required int score,
    required DateTime creationTime,
    required String title,
    String? url,
  }) = _Story;

  const Story._();

  String? prettyUrl() {
    final url = this.url;
    if (url == null) {
      return null;
    }

    return Uri.tryParse(url)?.host;
  }
}
