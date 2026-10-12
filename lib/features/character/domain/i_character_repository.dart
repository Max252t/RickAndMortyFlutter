import 'package:rickandmortyflutter/features/character/domain/character_model.dart';

abstract interface class ICharacterRepository {
  Future<List<CharacterModel>> getCharacters({String name = ''});

  Future<CharacterModel?> getCharacter(int id);

  Future<List<CharacterModel>> getResidents(int locationId);
}
