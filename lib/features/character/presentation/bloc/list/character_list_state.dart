import 'package:rickandmortyflutter/features/character/domain/character_model.dart';

sealed class CharacterListState {
  const CharacterListState({required this.query});

  final String query;
}

final class CharacterListLoading extends CharacterListState {
  const CharacterListLoading() : super(query: '');
}

final class CharacterListLoaded extends CharacterListState {
  const CharacterListLoaded(this.items, {required super.query});

  final List<CharacterModel> items;
}

final class CharacterListNotFound extends CharacterListState {
  const CharacterListNotFound({required super.query});
}
