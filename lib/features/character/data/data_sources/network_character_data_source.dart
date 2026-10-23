import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rickandmortyflutter/common/network/load_exception.dart';
import 'package:rickandmortyflutter/features/character/data/api/character_api.dart';
import 'package:rickandmortyflutter/features/character/data/data_sources/i_character_data_source.dart';
import 'package:rickandmortyflutter/features/character/data/dto/character_dto.dart';
import 'package:rickandmortyflutter/features/character/data/dto/character_page_dto.dart';
import 'package:rickandmortyflutter/features/character/data/dto/location_dto.dart';

final class NetworkCharacterDataSource implements ICharacterDataSource {
  const NetworkCharacterDataSource(this._api);

  final CharacterApi _api;

  @override
  Future<CharacterPageDto> getCharacters({
    required int page,
    required String name,
  }) => _guard(() => _api.getCharacters(page: page, name: name));

  @override
  Future<CharacterDto> getCharacter(int id) =>
      _guard(() => _api.getCharacter(id));

  @override
  Future<LocationDto> getLocation(int id) => _guard(() => _api.getLocation(id));

  Future<T> _guard<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (error) {
      throw _fromDio(error);
    } on CheckedFromJsonException {
      throw const BadResponseException();
    } on FormatException {
      throw const BadResponseException();
    }
  }

  LoadException _fromDio(DioException error) => switch (error.type) {
    DioExceptionType.connectionTimeout ||
    DioExceptionType.sendTimeout ||
    DioExceptionType.receiveTimeout ||
    DioExceptionType.transformTimeout => const TimeoutLoadException(),
    DioExceptionType.badResponse when error.response?.statusCode == 404 =>
      const NotFoundException(),
    DioExceptionType.badResponse => ServerException(error.response?.statusCode),
    DioExceptionType.unknown when error.error is FormatException =>
      const BadResponseException(),
    DioExceptionType.connectionError ||
    DioExceptionType.badCertificate ||
    DioExceptionType.cancel ||
    DioExceptionType.unknown => const NoConnectionException(),
  };
}
