import 'dart:math';

import 'package:cosmocloud/features/employee/employee_service.dart';
import 'package:cosmocloud/features/employee/employee_state.dart';
import 'package:cosmocloud/model/employee.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final employeeControllerProvider =
    StateNotifierProvider<EmployeeController, EmployeeState>((ref) {
  final employeeService = ref.watch(employeeServiceProvider);
  return EmployeeController(employeeService);
});

class EmployeeController extends StateNotifier<EmployeeState> {
  final EmployeeService _employeeService;

  EmployeeController(
    this._employeeService,
  ) : super(EmployeeState(
            employees: const AsyncValue.loading(),
            deleteEmployee: const AsyncValue.data(null),
            addEmployee: const AsyncValue.data(null))) {
    _getEmployees();
  }

  Future<void> _getEmployees() async {
    final res = await _employeeService.getEmployees();

    res.when((employees) {
      state = state.copyWith(employees: AsyncValue.data(employees));
    }, (failure) {
      state = state.copyWith(
          employees: AsyncValue.error(failure, failure.stackTrace));
    });
  }

  Future<void> addEmployee({
    required Employee employee,
  }) async {
    state = state.copyWith(addEmployee: const AsyncValue.loading());
    final res = await _employeeService.addEmployee(employee);

    res.when((value) {
      state = state.copyWith(
          addEmployee: AsyncValue.data(true),
          employees: AsyncValue.data([value, ...state.employees.value!]));
    }, (failure) {
      state = state.copyWith(
          addEmployee: AsyncValue.error(failure, failure.stackTrace));
    });
  }

  Future<void> deleteEmployee(String id) async {
    state = state.copyWith(deleteEmployee: const AsyncValue.loading());
    final res = await _employeeService.deleteEmployee(id);

    res.when((value) {
      state = state.copyWith(
          deleteEmployee: AsyncValue.data(true),
          employees: AsyncValue.data(state.employees.value!
              .where((element) => element.id != id)
              .toList()));
    }, (failure) {
      state = state.copyWith(
          deleteEmployee: AsyncValue.error(failure, failure.stackTrace));
    });
  }
}
