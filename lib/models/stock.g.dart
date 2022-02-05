// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stock _$StockFromJson(Map<String, dynamic> json) => Stock(
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
      id: json['_id'] as String?,
      branch: Branch.fromJson(json['branch'] as Map<String, dynamic>),
      quantity: json['quantity'] as int,
    );

Map<String, dynamic> _$StockToJson(Stock instance) => <String, dynamic>{
      '_id': instance.id,
      'product': instance.product,
      'branch': instance.branch,
      'quantity': instance.quantity,
    };
