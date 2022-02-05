import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product{

  @JsonKey(name: '_id')
  String? id;

  String name;
  String barcode;
  String seige_code;
  String supplier;
  String brand;
  int? purchase_price;
  int? sale_price;


  Product({required this.name, this.id, required this.barcode,required this.seige_code,required this.supplier,
    required this.brand,required this.purchase_price,required this.sale_price});

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
