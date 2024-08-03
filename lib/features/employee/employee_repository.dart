import 'dart:convert';
import 'dart:io';

import 'package:cosmocloud/core/environment.dart';
import 'package:cosmocloud/core/failure.dart';
import 'package:cosmocloud/model/employee.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

const baseURL =
    "https://free-ap-south-1.cosmocloud.io/development/api/employee";

final employeeRepositoryProvider = Provider<EmployeeRepository>(
  (ref) => EmployeeRepositoryImpl(),
);

abstract class EmployeeRepository {
  Future<List<Employee>> getEmployees();
  Future<Employee> addEmployee(Employee employee);
  Future<bool> deleteEmployee(String id);
}

class EmployeeRepositoryImpl implements EmployeeRepository {
  final _projectId = Environment.projectId;
  final _environmentId = Environment.environmentId;

  @override
  Future<List<Employee>> getEmployees() async {
    try {
      final res =
          await http.get(Uri.parse(baseURL + "?limit=50&offset=0"), headers: {
        'projectId': _projectId,
        'environmentId': _environmentId,
      });

      if (res.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(res.body);
        final List<dynamic> body = jsonData['data'];
        body.forEach((element) {
          element['id'] = element['_id'];
        });
        return body.map((e) => Employee.fromJson(e)).toList();
      } else {
        throw Failure(
          message: "Failed to load employees",
          stackTrace: StackTrace.current,
          code: res.statusCode,
        );
      }
    } on SocketException catch (e, s) {
      throw Failure(message: "No Internet", stackTrace: s);
    } on Failure catch (e) {
      rethrow;
    } catch (e) {
      throw Failure(
          message: "An error occurred while fetching employees",
          stackTrace: StackTrace.current);
    }
  }

  @override
  Future<Employee> addEmployee(Employee employee) async {
    final body = employee.toJson();
    body.remove('id');
    try {
      final res = await http.post(Uri.parse(baseURL),
          headers: {
            'projectId': _projectId,
            'environmentId': _environmentId,
            'Content-Type': 'application/json',
          },
          body: jsonEncode(body));

      if (res.statusCode == 201) {
        final Map<String, dynamic> jsonData = jsonDecode(res.body);
        final insertedRecord = employee.toJson();
        final address = employee.address.toJson();
        final contact = employee.contact.map((e) => e.toJson()).toList();
        insertedRecord['address'] = address;
        insertedRecord['contact'] = contact;
        insertedRecord['id'] = jsonData['id'];
        return Employee.fromJson(insertedRecord);
      } else {
        throw Failure(
          message: "Failed to add employee",
          stackTrace: StackTrace.current,
          code: res.statusCode,
        );
      }
    } on SocketException catch (e, s) {
      throw Failure(message: "No Internet", stackTrace: s);
    } on Failure catch (e) {
      rethrow;
    } catch (e) {
      throw Failure(
          message: "An error occurred while adding employee",
          stackTrace: StackTrace.current);
    }
  }

  @override
  Future<bool> deleteEmployee(String id) async {
    try {
      final res = await http.delete(Uri.parse(baseURL + "/$id"),
          headers: {
            'projectId': _projectId,
            'environmentId': _environmentId,
          },
          body: jsonEncode({}));

      if (res.statusCode == 200) {
        return true;
      } else {
        throw Failure(
          message: "Failed to delete employee",
          stackTrace: StackTrace.current,
          code: res.statusCode,
        );
      }
    } on SocketException catch (e, s) {
      throw Failure(message: "No Internet", stackTrace: s);
    } on Failure catch (e) {
      rethrow;
    } catch (e) {
      throw Failure(
          message: "An error occurred while deleting employee",
          stackTrace: StackTrace.current);
    }
  }
}
