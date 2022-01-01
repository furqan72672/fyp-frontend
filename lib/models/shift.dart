import 'package:json_annotation/json_annotation.dart';

part 'shift.g.dart';

@JsonSerializable()
class Shift{
  int from;
  int to;
  Shift({required this.from, required this.to});

  factory Shift.fromJson(Map<String, dynamic> json) => _$ShiftFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ShiftToJson(this);
}
