import 'package:json_annotation/json_annotation.dart';

part 'employee.g.dart';

@JsonSerializable()
class Address {
  final String line1;
  final String city;
  final String country;
  final int zip_code;

  Address({
    required this.line1,
    required this.city,
    required this.country,
    required this.zip_code,
  });

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

@JsonSerializable()
class ContactObject {
  final String type;
  final String value;

  ContactObject({
    required this.type,
    required this.value,
  });

  factory ContactObject.fromJson(Map<String, dynamic> json) =>
      _$ContactObjectFromJson(json);

  Map<String, dynamic> toJson() => _$ContactObjectToJson(this);
}

@JsonSerializable()
class Employee {
  final String id;
  final String name;
  final Address address;
  final List<ContactObject> contact;

  Employee({
    required this.id,
    required this.name,
    required this.address,
    required this.contact,
  });

  factory Employee.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeToJson(this);
}
