import 'package:rickandmortyflutter/features/character/data/dto/character_dto.dart';
import 'package:rickandmortyflutter/features/character/data/dto/character_page_dto.dart';
import 'package:rickandmortyflutter/features/character/data/dto/location_dto.dart';

abstract interface class ICharacterDataSource {
  Future<CharacterPageDto> getCharacters({
    required int page,
    required String name,
  });

  Future<CharacterDto> getCharacter(int id);

  Future<LocationDto> getLocation(int id);
}
