import 'package:fyp_ims/models/location.dart';
import 'package:fyp_ims/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'branch.g.dart';

@JsonSerializable()
class Branch{

  @JsonKey(name: '_id')
  String? id;

  String store_name;
  int? rent;
  Location location;


  Branch({required this.store_name, this.id, required this.location,this.rent});

  factory Branch.fromJson(Map<String, dynamic> json) => _$BranchFromJson(json);

  Map<String, dynamic> toJson() => _$BranchToJson(this);
}
