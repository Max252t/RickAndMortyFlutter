import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmortyflutter/common/network/load_exception.dart';
import 'package:rickandmortyflutter/features/character/domain/character_model.dart';
import 'package:rickandmortyflutter/features/character/domain/i_character_repository.dart';
import 'package:rickandmortyflutter/features/character/presentation/bloc/detail/character_detail_event.dart';
import 'package:rickandmortyflutter/features/character/presentation/bloc/detail/character_detail_state.dart';

class CharacterDetailBloc
    extends Bloc<CharacterDetailEvent, CharacterDetailState> {
  CharacterDetailBloc(this._repository)
    : super(const CharacterDetailLoading()) {
    on<CharacterDetailOpened>(_onLoadRequested);
    on<CharacterDetailRetried>(_onLoadRequested);
  }

  final ICharacterRepository _repository;

  Future<void> _onLoadRequested(
    CharacterDetailEvent event,
    Emitter<CharacterDetailState> emit,
  ) async {
    emit(const CharacterDetailLoading());
    try {
      final character = await _repository.getCharacter(event.id);
      final neighbours = await _loadNeighbours(character);
      emit(CharacterDetailLoaded(character, neighbours: neighbours));
    } on NotFoundException {
      emit(CharacterDetailNotFound(event.id));
    } on LoadException catch (error) {
      emit(CharacterDetailFailure(event.id, error));
    }
  }

  Future<List<CharacterModel>> _loadNeighbours(CharacterModel character) async {
    final locationId = character.location.id;
    if (locationId == null) return const [];
    try {
      return await _repository.getResidents(locationId, exceptId: character.id);
    } on NotFoundException {
      return const [];
    }
  }
}
