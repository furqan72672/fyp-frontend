import 'package:json_annotation/json_annotation.dart';

part 'signIn.g.dart';

@JsonSerializable()
class SignIn{
  String email;
  String password;

  SignIn({required this.email,required this.password});

  factory SignIn.fromJson(Map<String, dynamic> json) => _$SignInFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SignInToJson(this);

}