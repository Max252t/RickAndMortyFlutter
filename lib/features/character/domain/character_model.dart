final class CharacterModel {
  const CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episodeIds,
    required this.created,
  });

  final int id;
  final String name;
  final CharacterStatus status;
  final String species;

  final String type;
  final CharacterGender gender;
  final LocationRefModel origin;

  final LocationRefModel location;
  final String image;
  final List<int> episodeIds;
  final DateTime created;
}

final class LocationRefModel {
  const LocationRefModel({required this.id, required this.name});

  final int? id;
  final String name;
}

enum CharacterStatus { alive, dead, unknown }

enum CharacterGender { female, male, genderless, unknown }
