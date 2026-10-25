import 'package:rickandmortyflutter/common/network/load_exception.dart';
import 'package:rickandmortyflutter/features/character/domain/character_model.dart';

sealed class CharacterListState {
  const CharacterListState({required this.query});

  final String query;
}

final class CharacterListLoading extends CharacterListState {
  const CharacterListLoading({required super.query});
}

final class CharacterListLoaded extends CharacterListState {
  const CharacterListLoaded(
    this.items, {
    required super.query,
    required this.nextPage,
    this.isLoadingMore = false,
    this.loadMoreError,
  });

  final List<CharacterModel> items;
  final int? nextPage;
  final bool isLoadingMore;
  final LoadException? loadMoreError;
}

final class CharacterListNotFound extends CharacterListState {
  const CharacterListNotFound({required super.query});
}

final class CharacterListFailure extends CharacterListState {
  const CharacterListFailure(this.error, {required super.query});

  final LoadException error;
}
