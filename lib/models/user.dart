import 'package:fyp_ims/models/address.dart';
import 'package:fyp_ims/models/branch.dart';
import 'package:fyp_ims/models/shift.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User{
  @JsonKey(name: '_id')
  String? id;

  String name;
  String email;
  String password;
  Shift? shift;
  Address? address;
  int? target;
  int? salary;
  String? phone;
  int? visa;
  int? guard;
  List<Branch>? branch;


  User({this.id, required this.name, required this.email, required this.password, this.guard, this.shift,
      this.address, this.target, this.salary, this.phone, this.visa, this.branch});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserToJson(this);

}
