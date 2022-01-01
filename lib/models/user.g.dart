// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      guard: json['guard'] as int?,
      shift: json['shift'] == null
          ? null
          : Shift.fromJson(json['shift'] as Map<String, dynamic>),
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      target: json['target'] as int?,
      salary: json['salary'] as int?,
      phone: json['phone'] as String?,
      visa: json['visa'] as int?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'shift': instance.shift,
      'address': instance.address,
      'target': instance.target,
      'salary': instance.salary,
      'phone': instance.phone,
      'visa': instance.visa,
      'guard': instance.guard,
    };
