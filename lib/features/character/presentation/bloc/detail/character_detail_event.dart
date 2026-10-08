sealed class CharacterDetailEvent {
  const CharacterDetailEvent();
}

final class CharacterDetailOpened extends CharacterDetailEvent {
  const CharacterDetailOpened(this.id);

  final int id;
}
