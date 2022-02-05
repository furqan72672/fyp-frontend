import 'package:fyp_ims/models/product.dart';
import 'package:fyp_ims/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'request.g.dart';

@JsonSerializable()
class Request{

  @JsonKey(name: '_id')
  String? id;

  Product product;
  User user;
  int quantity;
  int type;
  var createdAt;


  Request({required this.product, this.id, required this.user,required this.quantity,required this.type, required this.createdAt});

  factory Request.fromJson(Map<String, dynamic> json) => _$RequestFromJson(json);

  Map<String, dynamic> toJson() => _$RequestToJson(this);
}
