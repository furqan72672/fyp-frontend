// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      name: json['name'] as String,
      id: json['_id'] as String?,
      barcode: json['barcode'] as String,
      seige_code: json['seige_code'] as String,
      supplier: json['supplier'] as String,
      brand: json['brand'] as String,
      purchase_price: json['purchase_price'] as int?,
      sale_price: json['sale_price'] as int?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'barcode': instance.barcode,
      'seige_code': instance.seige_code,
      'supplier': instance.supplier,
      'brand': instance.brand,
      'purchase_price': instance.purchase_price,
      'sale_price': instance.sale_price,
    };
