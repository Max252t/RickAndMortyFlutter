sealed class CharacterDetailEvent {
  const CharacterDetailEvent(this.id);

  final int id;
}

final class CharacterDetailOpened extends CharacterDetailEvent {
  const CharacterDetailOpened(super.id);
}

final class CharacterDetailRetried extends CharacterDetailEvent {
  const CharacterDetailRetried(super.id);
}
