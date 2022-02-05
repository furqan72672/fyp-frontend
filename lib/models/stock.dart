import 'package:fyp_ims/models/branch.dart';
import 'package:fyp_ims/models/product.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stock.g.dart';

@JsonSerializable()
class Stock{

  @JsonKey(name: '_id')
  String? id;

  Product product;
  Branch branch;
  int quantity;


  Stock({required this.product, this.id, required this.branch,required this.quantity});

  factory Stock.fromJson(Map<String, dynamic> json) => _$StockFromJson(json);

  Map<String, dynamic> toJson() => _$StockToJson(this);
}
