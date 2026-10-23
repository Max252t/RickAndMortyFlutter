import 'package:json_annotation/json_annotation.dart';

part 'page_info_dto.g.dart';

@JsonSerializable()
class PageInfoDto {
  const PageInfoDto({required this.count, required this.pages, this.next});

  factory PageInfoDto.fromJson(Map<String, dynamic> json) =>
      _$PageInfoDtoFromJson(json);

  final int count;
  final int pages;
  final String? next;
}
