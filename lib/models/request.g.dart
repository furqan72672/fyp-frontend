// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Request _$RequestFromJson(Map<String, dynamic> json) => Request(
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
      id: json['_id'] as String?,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      quantity: json['quantity'] as int,
      type: json['type'] as int,
      createdAt: json['createdAt'],
    );

Map<String, dynamic> _$RequestToJson(Request instance) => <String, dynamic>{
      '_id': instance.id,
      'product': instance.product,
      'user': instance.user,
      'quantity': instance.quantity,
      'type': instance.type,
      'createdAt': instance.createdAt,
    };
