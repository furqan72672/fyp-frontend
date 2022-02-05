import 'package:fyp_ims/models/branch.dart';
import 'package:fyp_ims/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sale.g.dart';

@JsonSerializable()
class Sale{

  @JsonKey(name: '_id')
  String? id;

  String product;
  User user;
  int sold;


  Sale({required this.product, this.id, required this.user,required this.sold});

  factory Sale.fromJson(Map<String, dynamic> json) => _$SaleFromJson(json);

  Map<String, dynamic> toJson() => _$SaleToJson(this);
}
