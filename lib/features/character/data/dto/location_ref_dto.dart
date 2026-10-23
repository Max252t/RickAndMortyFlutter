import 'package:json_annotation/json_annotation.dart';

part 'location_ref_dto.g.dart';

@JsonSerializable()
class LocationRefDto {
  const LocationRefDto({required this.name, required this.url});

  factory LocationRefDto.fromJson(Map<String, dynamic> json) =>
      _$LocationRefDtoFromJson(json);

  final String name;
  final String url;
}
