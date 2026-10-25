import 'package:json_annotation/json_annotation.dart';

part 'location_dto.g.dart';

@JsonSerializable()
class LocationDto {
  const LocationDto({
    required this.id,
    required this.name,
    required this.residents,
  });

  factory LocationDto.fromJson(Map<String, dynamic> json) =>
      _$LocationDtoFromJson(json);

  final int id;
  final String name;
  final List<String> residents;
}
