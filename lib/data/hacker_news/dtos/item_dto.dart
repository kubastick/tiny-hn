import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tiny_hn/data/hacker_news/dtos/item_type_dto.dart';

part 'item_dto.g.dart';

@JsonSerializable()
class ItemDTO {
  const ItemDTO({
    required this.id,
    required this.deleted,
    required this.type,
    required this.time,
    required this.dead,
    this.by,
    this.text,
    this.parent,
    this.poll,
    this.kids,
    this.url,
    this.score,
    this.title,
    this.parts,
    this.descendants,
  });

  factory ItemDTO.fromJson(Map<String, dynamic> json) => _$ItemDTOFromJson(json);

  final int id;
  @JsonKey(defaultValue: false)
  final bool deleted;
  final ItemTypeDTO type;
  final int time;
  @JsonKey(defaultValue: false)
  final bool dead;
  final String? by;
  final String? text;
  final int? parent;
  final int? poll;
  final List<int>? kids;
  final String? url;
  final int? score;
  final String? title;
  final List<int>? parts;
  final int? descendants;

  Map<String, dynamic> toJson() => _$ItemDTOToJson(this);
}
