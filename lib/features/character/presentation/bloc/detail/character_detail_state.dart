import 'package:rickandmortyflutter/features/character/domain/character_model.dart';

sealed class CharacterDetailState {
  const CharacterDetailState();
}

final class CharacterDetailLoading extends CharacterDetailState {
  const CharacterDetailLoading();
}

final class CharacterDetailLoaded extends CharacterDetailState {
  const CharacterDetailLoaded(this.character, {required this.neighbours});

  final CharacterModel character;

  final List<CharacterModel> neighbours;
}

final class CharacterDetailNotFound extends CharacterDetailState {
  const CharacterDetailNotFound(this.id);

  final int id;
}
