import 'package:rickandmortyflutter/common/network/load_exception.dart';
import 'package:rickandmortyflutter/features/character/data/data_sources/i_character_data_source.dart';
import 'package:rickandmortyflutter/features/character/data/mappers/character_mapper.dart';
import 'package:rickandmortyflutter/features/character/domain/character_model.dart';
import 'package:rickandmortyflutter/features/character/domain/character_page_model.dart';
import 'package:rickandmortyflutter/features/character/domain/i_character_repository.dart';

final class CharacterRepository implements ICharacterRepository {
  const CharacterRepository(this._dataSource);

  final ICharacterDataSource _dataSource;

  static const int _residentsLimit = 20;

  @override
  Future<CharacterPageModel> getCharacters({
    required int page,
    String name = '',
  }) async {
    try {
      final dto = await _dataSource.getCharacters(
        page: page,
        name: name.trim(),
      );
      return dto.toModel();
    } on NotFoundException {
      return CharacterPageModel.empty;
    }
  }

  @override
  Future<CharacterModel> getCharacter(int id) async =>
      (await _dataSource.getCharacter(id)).toModel();

  @override
  Future<List<CharacterModel>> getResidents(
    int locationId, {
    int? exceptId,
  }) async {
    final location = await _dataSource.getLocation(locationId);
    final ids = location.residentIds
        .where((id) => id != exceptId)
        .take(_residentsLimit);
    final dtos = await Future.wait([
      for (final id in ids) _dataSource.getCharacter(id),
    ]);
    return [for (final dto in dtos) dto.toModel()];
  }
}
