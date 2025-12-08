// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextDto _$TextDtoFromJson(Map<String, dynamic> json) => TextDto(
  name: json['name'] as String,
  words: (json['words'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$TextDtoToJson(TextDto instance) => <String, dynamic>{
  'name': instance.name,
  'words': instance.words,
};
