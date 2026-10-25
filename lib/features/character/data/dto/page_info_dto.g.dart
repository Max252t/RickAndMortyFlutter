// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageInfoDto _$PageInfoDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PageInfoDto', json, ($checkedConvert) {
      final val = PageInfoDto(
        count: $checkedConvert('count', (v) => (v as num).toInt()),
        pages: $checkedConvert('pages', (v) => (v as num).toInt()),
        next: $checkedConvert('next', (v) => v as String?),
      );
      return val;
    });
