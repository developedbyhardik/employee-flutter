import 'package:cosmocloud/core/failure.dart';
import 'package:cosmocloud/features/employee/employee_repository.dart';
import 'package:cosmocloud/model/employee.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';

final employeeServiceProvider = Provider<EmployeeService>((ref) {
  final employeeRepository = ref.watch(employeeRepositoryProvider);
  return EmployeeServiceImpl(employeeRepository);
});

abstract class EmployeeService {
  Future<Result<List<Employee>, Failure>> getEmployees();
  Future<Result<Employee, Failure>> addEmployee(Employee employee);
  Future<Result<bool, Failure>> deleteEmployee(String id);
}

class EmployeeServiceImpl implements EmployeeService {
  final EmployeeRepository _employeeRepository;

  EmployeeServiceImpl(this._employeeRepository);

  @override
  Future<Result<List<Employee>, Failure>> getEmployees() async {
    try {
      final employees = await _employeeRepository.getEmployees();
      return Success(employees);
    } catch (e) {
      final error = e as Failure;
      return Error(error);
    }
  }

  @override
  Future<Result<Employee, Failure>> addEmployee(Employee employee) async {
    try {
      final res = await _employeeRepository.addEmployee(employee);
      return Success(res);
    } catch (e) {
      final error = e as Failure;
      return Error(error);
    }
  }

  @override
  Future<Result<bool, Failure>> deleteEmployee(String id) async {
    try {
      final res = await _employeeRepository.deleteEmployee(id);
      return Success(res);
    } catch (e) {
      final error = e as Failure;
      return Error(error);
    }
  }
}
