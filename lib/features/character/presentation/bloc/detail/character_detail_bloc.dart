import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmortyflutter/features/character/domain/character_model.dart';
import 'package:rickandmortyflutter/features/character/domain/i_character_repository.dart';
import 'package:rickandmortyflutter/features/character/presentation/bloc/detail/character_detail_event.dart';
import 'package:rickandmortyflutter/features/character/presentation/bloc/detail/character_detail_state.dart';

class CharacterDetailBloc
    extends Bloc<CharacterDetailEvent, CharacterDetailState> {
  CharacterDetailBloc(this._repository)
    : super(const CharacterDetailLoading()) {
    on<CharacterDetailOpened>(_onOpened);
  }

  final ICharacterRepository _repository;

  Future<void> _onOpened(
    CharacterDetailOpened event,
    Emitter<CharacterDetailState> emit,
  ) async {
    final character = await _repository.getCharacter(event.id);
    if (character == null) {
      emit(CharacterDetailNotFound(event.id));
      return;
    }
    final locationId = character.location.id;
    final residents = locationId == null
        ? const <CharacterModel>[]
        : await _repository.getResidents(locationId);
    emit(
      CharacterDetailLoaded(
        character,
        neighbours: [
          for (final resident in residents)
            if (resident.id != character.id) resident,
        ],
      ),
    );
  }
}
