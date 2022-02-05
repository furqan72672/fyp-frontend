// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Branch _$BranchFromJson(Map<String, dynamic> json) => Branch(
      store_name: json['store_name'] as String,
      id: json['_id'] as String?,
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      rent: json['rent'] as int?,
    );

Map<String, dynamic> _$BranchToJson(Branch instance) => <String, dynamic>{
      '_id': instance.id,
      'store_name': instance.store_name,
      'rent': instance.rent,
      'location': instance.location,
    };
