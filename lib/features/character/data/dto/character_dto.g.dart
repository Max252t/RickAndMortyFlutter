// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacterDto _$CharacterDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CharacterDto', json, ($checkedConvert) {
      final val = CharacterDto(
        id: $checkedConvert('id', (v) => (v as num).toInt()),
        name: $checkedConvert('name', (v) => v as String),
        status: $checkedConvert('status', (v) => v as String),
        species: $checkedConvert('species', (v) => v as String),
        type: $checkedConvert('type', (v) => v as String),
        gender: $checkedConvert('gender', (v) => v as String),
        origin: $checkedConvert(
          'origin',
          (v) => LocationRefDto.fromJson(v as Map<String, dynamic>),
        ),
        location: $checkedConvert(
          'location',
          (v) => LocationRefDto.fromJson(v as Map<String, dynamic>),
        ),
        image: $checkedConvert('image', (v) => v as String),
        episode: $checkedConvert(
          'episode',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
        created: $checkedConvert('created', (v) => v as String),
      );
      return val;
    });
