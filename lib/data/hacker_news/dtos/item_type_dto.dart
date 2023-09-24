import 'package:freezed_annotation/freezed_annotation.dart';

enum ItemTypeDTO {
  job,
  story,
  comment,
  poll,
  @JsonValue('pollopt')
  pollOpt,
}
