import 'package:rickandmortyflutter/features/character/domain/character_model.dart';
import 'package:rickandmortyflutter/features/character/domain/character_page_model.dart';

abstract interface class ICharacterRepository {
  Future<CharacterPageModel> getCharacters({
    required int page,
    String name = '',
  });

  Future<CharacterModel> getCharacter(int id);

  Future<List<CharacterModel>> getResidents(int locationId, {int? exceptId});
}
