import 'package:json_annotation/json_annotation.dart';
import 'package:rickandmortyflutter/features/character/data/dto/location_ref_dto.dart';

part 'character_dto.g.dart';

@JsonSerializable()
class CharacterDto {
  const CharacterDto({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.created,
  });

  factory CharacterDto.fromJson(Map<String, dynamic> json) =>
      _$CharacterDtoFromJson(json);

  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final LocationRefDto origin;
  final LocationRefDto location;
  final String image;
  final List<String> episode;
  final String created;
}
