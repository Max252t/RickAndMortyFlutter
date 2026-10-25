import 'package:json_annotation/json_annotation.dart';
import 'package:rickandmortyflutter/features/character/data/dto/character_dto.dart';
import 'package:rickandmortyflutter/features/character/data/dto/page_info_dto.dart';

part 'character_page_dto.g.dart';

@JsonSerializable()
class CharacterPageDto {
  const CharacterPageDto({required this.info, required this.results});

  factory CharacterPageDto.fromJson(Map<String, dynamic> json) =>
      _$CharacterPageDtoFromJson(json);

  final PageInfoDto info;
  final List<CharacterDto> results;
}
