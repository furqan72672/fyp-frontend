// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sale _$SaleFromJson(Map<String, dynamic> json) => Sale(
      product: json['product'] as String,
      id: json['_id'] as String?,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      sold: json['sold'] as int,
    );

Map<String, dynamic> _$SaleToJson(Sale instance) => <String, dynamic>{
      '_id': instance.id,
      'product': instance.product,
      'user': instance.user,
      'sold': instance.sold,
    };
