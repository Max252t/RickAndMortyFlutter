import 'package:rickandmortyflutter/features/character/domain/character_model.dart';

final class CharacterPageModel {
  const CharacterPageModel({required this.items, required this.hasMore});

  static const CharacterPageModel empty = CharacterPageModel(
    items: [],
    hasMore: false,
  );

  final List<CharacterModel> items;
  final bool hasMore;
}
