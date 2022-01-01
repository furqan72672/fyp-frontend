import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable()
class Address {
  String line1;
  String? line2;
  String city;
  String state;
  String country;
  int zip;

  Address({required this.line1,
    this.line2,
    required this.city,
    required this.state,
    required this.country,
    required this.zip});

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
