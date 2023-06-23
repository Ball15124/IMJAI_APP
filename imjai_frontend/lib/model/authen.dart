import 'package:json_annotation/json_annotation.dart';

part 'authen.g.dart';

@JsonSerializable()
class CallbackResponse {
  @JsonKey(name: 'token')
  final String token;

  CallbackResponse({
    required this.token,
  });

  factory CallbackResponse.fromJson(Map<String, dynamic> json) =>
      _$CallbackResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CallbackResponseToJson(this);
}
