sealed class CharacterListEvent {
  const CharacterListEvent();
}

final class CharacterListStarted extends CharacterListEvent {
  const CharacterListStarted();
}

final class CharacterListQueryChanged extends CharacterListEvent {
  const CharacterListQueryChanged(this.query);

  final String query;
}
