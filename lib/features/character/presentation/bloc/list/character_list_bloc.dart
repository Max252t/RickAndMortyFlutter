import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmortyflutter/common/network/load_exception.dart';
import 'package:rickandmortyflutter/features/character/domain/i_character_repository.dart';
import 'package:rickandmortyflutter/features/character/presentation/bloc/list/character_list_event.dart';
import 'package:rickandmortyflutter/features/character/presentation/bloc/list/character_list_state.dart';

class CharacterListBloc extends Bloc<CharacterListEvent, CharacterListState> {
  CharacterListBloc(this._repository)
    : super(const CharacterListLoading(query: '')) {
    on<CharacterListStarted>((event, emit) => _load('', emit));
    on<CharacterListRetried>((event, emit) => _load(state.query, emit));
    on<CharacterListQueryChanged>(_onQueryChanged, transformer: restartable());
    on<CharacterListNextPageRequested>(
      _onNextPageRequested,
      transformer: droppable(),
    );
  }

  final ICharacterRepository _repository;

  static const Duration _searchDelay = Duration(milliseconds: 400);

  Future<void> _onQueryChanged(
    CharacterListQueryChanged event,
    Emitter<CharacterListState> emit,
  ) async {
    await Future<void>.delayed(_searchDelay);
    if (emit.isDone) return;
    await _load(event.query, emit);
  }

  Future<void> _load(String query, Emitter<CharacterListState> emit) async {
    emit(CharacterListLoading(query: query));
    try {
      final page = await _repository.getCharacters(page: 1, name: query);
      if (state.query != query) return;
      emit(
        page.items.isEmpty
            ? CharacterListNotFound(query: query)
            : CharacterListLoaded(
                page.items,
                query: query,
                nextPage: page.hasMore ? 2 : null,
              ),
      );
    } on LoadException catch (error) {
      if (state.query != query) return;
      emit(CharacterListFailure(error, query: query));
    }
  }

  Future<void> _onNextPageRequested(
    CharacterListNextPageRequested event,
    Emitter<CharacterListState> emit,
  ) async {
    final current = state;
    if (current is! CharacterListLoaded || current.isLoadingMore) return;
    final nextPage = current.nextPage;
    if (nextPage == null) return;
    emit(
      CharacterListLoaded(
        current.items,
        query: current.query,
        nextPage: nextPage,
        isLoadingMore: true,
      ),
    );
    try {
      final page = await _repository.getCharacters(
        page: nextPage,
        name: current.query,
      );
      if (!_isStillShowing(current)) return;
      emit(
        CharacterListLoaded(
          [...current.items, ...page.items],
          query: current.query,
          nextPage: page.hasMore ? nextPage + 1 : null,
        ),
      );
    } on LoadException catch (error) {
      if (!_isStillShowing(current)) return;
      emit(
        CharacterListLoaded(
          current.items,
          query: current.query,
          nextPage: nextPage,
          loadMoreError: error,
        ),
      );
    }
  }

  bool _isStillShowing(CharacterListLoaded previous) {
    final now = state;
    return now is CharacterListLoaded &&
        now.query == previous.query &&
        identical(now.items, previous.items);
  }
}
