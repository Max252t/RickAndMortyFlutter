import 'package:rickandmortyflutter/features/character/data/mock_characters.dart';
import 'package:rickandmortyflutter/features/character/domain/character_model.dart';
import 'package:rickandmortyflutter/features/character/domain/i_character_repository.dart';

final class CharacterRepository implements ICharacterRepository {
  const CharacterRepository();

  @override
  Future<List<CharacterModel>> getCharacters({String name = ''}) async {
    final needle = name.trim().toLowerCase();
    if (needle.isEmpty) return mockCharacters;
    return [
      for (final character in mockCharacters)
        if (character.name.toLowerCase().contains(needle)) character,
    ];
  }

  @override
  Future<CharacterModel?> getCharacter(int id) async {
    for (final character in mockCharacters) {
      if (character.id == id) return character;
    }
    return null;
  }

  @override
  Future<List<CharacterModel>> getResidents(int locationId) async => [
    for (final character in mockCharacters)
      if (character.location.id == locationId) character,
  ];
}
