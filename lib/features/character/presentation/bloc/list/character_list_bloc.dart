import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmortyflutter/features/character/domain/i_character_repository.dart';
import 'package:rickandmortyflutter/features/character/presentation/bloc/list/character_list_event.dart';
import 'package:rickandmortyflutter/features/character/presentation/bloc/list/character_list_state.dart';

class CharacterListBloc extends Bloc<CharacterListEvent, CharacterListState> {
  CharacterListBloc(this._repository) : super(const CharacterListLoading()) {
    on<CharacterListStarted>((event, emit) => _search('', emit));
    on<CharacterListQueryChanged>(
      (event, emit) => _search(event.query, emit),
      transformer: restartable(),
    );
  }

  final ICharacterRepository _repository;

  Future<void> _search(String query, Emitter<CharacterListState> emit) async {
    final items = await _repository.getCharacters(name: query);
    emit(
      items.isEmpty
          ? CharacterListNotFound(query: query)
          : CharacterListLoaded(items, query: query),
    );
  }
}
