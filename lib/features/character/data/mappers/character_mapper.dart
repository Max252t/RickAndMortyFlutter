import 'package:rickandmortyflutter/features/character/data/dto/character_dto.dart';
import 'package:rickandmortyflutter/features/character/data/dto/character_page_dto.dart';
import 'package:rickandmortyflutter/features/character/data/dto/location_dto.dart';
import 'package:rickandmortyflutter/features/character/data/dto/location_ref_dto.dart';
import 'package:rickandmortyflutter/features/character/domain/character_model.dart';
import 'package:rickandmortyflutter/features/character/domain/character_page_model.dart';

extension CharacterDtoMapper on CharacterDto {
  CharacterModel toModel() => CharacterModel(
    id: id,
    name: name,
    status: switch (status.toLowerCase()) {
      'alive' => CharacterStatus.alive,
      'dead' => CharacterStatus.dead,
      _ => CharacterStatus.unknown,
    },
    species: species,
    type: type,
    gender: switch (gender.toLowerCase()) {
      'female' => CharacterGender.female,
      'male' => CharacterGender.male,
      'genderless' => CharacterGender.genderless,
      _ => CharacterGender.unknown,
    },
    origin: origin.toModel(),
    location: location.toModel(),
    image: image,
    episodeIds: [for (final url in episode) ?idFromUrl(url)],
    created: DateTime.parse(created),
  );
}

extension LocationRefDtoMapper on LocationRefDto {
  LocationRefModel toModel() =>
      LocationRefModel(id: idFromUrl(url), name: name);
}

extension CharacterPageDtoMapper on CharacterPageDto {
  CharacterPageModel toModel() => CharacterPageModel(
    items: [for (final dto in results) dto.toModel()],
    hasMore: info.next != null,
  );
}

extension LocationDtoMapper on LocationDto {
  List<int> get residentIds => [for (final url in residents) ?idFromUrl(url)];
}

int? idFromUrl(String url) {
  final segments = Uri.tryParse(url)?.pathSegments ?? const <String>[];
  final last = segments.lastWhere(
    (segment) => segment.isNotEmpty,
    orElse: () => '',
  );
  return int.tryParse(last);
}
