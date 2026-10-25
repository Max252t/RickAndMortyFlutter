import 'package:dio/dio.dart';
import 'package:rickandmortyflutter/features/character/data/dto/character_dto.dart';
import 'package:rickandmortyflutter/features/character/data/dto/character_page_dto.dart';
import 'package:rickandmortyflutter/features/character/data/dto/location_dto.dart';

final class CharacterApi {
  const CharacterApi(this._dio);

  final Dio _dio;

  Future<CharacterPageDto> getCharacters({
    required int page,
    required String name,
  }) async {
    final json = await _getJson(
      '/character',
      queryParameters: {'page': page, if (name.isNotEmpty) 'name': name},
    );
    return CharacterPageDto.fromJson(json);
  }

  Future<CharacterDto> getCharacter(int id) async =>
      CharacterDto.fromJson(await _getJson('/character/$id'));

  Future<LocationDto> getLocation(int id) async =>
      LocationDto.fromJson(await _getJson('/location/$id'));

  Future<Map<String, dynamic>> _getJson(
    String path, {
    Map<String, Object>? queryParameters,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      path,
      queryParameters: queryParameters,
    );
    return response.data ?? (throw const FormatException('Empty response'));
  }
}
