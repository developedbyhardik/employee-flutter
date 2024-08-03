// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      line1: json['line1'] as String,
      city: json['city'] as String,
      country: json['country'] as String,
      zip_code: (json['zip_code'] as num).toInt(),
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'line1': instance.line1,
      'city': instance.city,
      'country': instance.country,
      'zip_code': instance.zip_code,
    };

ContactObject _$ContactObjectFromJson(Map<String, dynamic> json) =>
    ContactObject(
      type: json['type'] as String,
      value: json['value'] as String,
    );

Map<String, dynamic> _$ContactObjectToJson(ContactObject instance) =>
    <String, dynamic>{
      'type': instance.type,
      'value': instance.value,
    };

Employee _$EmployeeFromJson(Map<String, dynamic> json) => Employee(
      id: json['id'] as String,
      name: json['name'] as String,
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
      contact: (json['contact'] as List<dynamic>)
          .map((e) => ContactObject.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'contact': instance.contact,
    };
