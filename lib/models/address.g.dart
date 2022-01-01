// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      line1: json['line1'] as String,
      line2: json['line2'] as String?,
      city: json['city'] as String,
      state: json['state'] as String,
      country: json['country'] as String,
      zip: json['zip'] as int,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'line1': instance.line1,
      'line2': instance.line2,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'zip': instance.zip,
    };
