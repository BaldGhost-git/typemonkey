import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:typingapp/features/typing/domain/text.dart';

part 'text_dto.freezed.dart';
part 'text_dto.g.dart';

@JsonSerializable()
@freezed
class TextDto with _$TextDto {
  @override
  final String name;
  @override
  final List<String> words;

  TextDto({required this.name, required this.words});

  factory TextDto.fromJson(Map<String, dynamic> json) =>
      _$TextDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TextDtoToJson(this);

  TextTyping toEntity() {
    final String combinedWords = words.join(' ');
    return TextTyping.fromString(combinedWords);
  }
}
