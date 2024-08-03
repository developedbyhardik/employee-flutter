import 'package:cosmocloud/model/employee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@immutable
class EmployeeState {
  final AsyncValue<List<Employee>> employees;
  final AsyncValue<bool?> addEmployee;
  final AsyncValue<bool?> deleteEmployee;

  EmployeeState(
      {required this.employees,
      required this.addEmployee,
      required this.deleteEmployee});

  EmployeeState copyWith({
    AsyncValue<List<Employee>>? employees,
    AsyncValue<bool?>? addEmployee,
    AsyncValue<bool?>? deleteEmployee,
  }) {
    return EmployeeState(
      employees: employees ?? this.employees,
      addEmployee: addEmployee ?? this.addEmployee,
      deleteEmployee: deleteEmployee ?? this.deleteEmployee,
    );
  }

  @override
  String toString() =>
      'EmployeeState(employees: $employees, addEmployee: $addEmployee , deleteEmployee: $deleteEmployee)';
}
