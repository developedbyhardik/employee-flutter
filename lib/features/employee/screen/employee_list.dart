import 'package:cosmocloud/constants/size.dart';
import 'package:cosmocloud/features/employee/employee_controller.dart';
import 'package:cosmocloud/features/employee/screen/add_employee.dart';
import 'package:cosmocloud/features/employee/screen/employee_details.dart';
import 'package:cosmocloud/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class EmployeeListScreen extends ConsumerWidget {
  const EmployeeListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 5,
        backgroundColor: Palette.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.largeBorderRadius * 10),
        ),
        child: Icon(
          PhosphorIcons.plus(PhosphorIconsStyle.bold),
          size: 30,
          color: Palette.white,
        ),
        onPressed: () {
          Navigator.of(context).push(AddEmployeeScreen.route());
        },
      ),
      body: SafeArea(
          child: ref
              .watch(
                  employeeControllerProvider.select((value) => value.employees))
              .when(data: (employees) {
        return ListView.builder(
          itemCount: employees.length,
          itemBuilder: (context, index) {
            final employee = employees[index];
            return Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: AppSize.smallSpace * 1.5,
                  vertical: AppSize.smallSpace),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(AppSize.mediumBorderRadius),
                border: Border.all(
                  color: Palette.blue,
                  width: 1,
                ),
              ),
              child: ListTile(
                onTap: () {
                  Navigator.of(context)
                      .push(EmployeeDetailsScreen.route(employee));
                },
                title: Text(
                  employee.name,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontFamily: "CircularStd-Medium",
                      ),
                ),
                subtitle: Text(employee.id),
                leading: CircleAvatar(
                  child: Text(employee.name[0]),
                ),
              ),
            );
          },
        );
      }, error: (e, s) {
        return EmployeeListError();
      }, loading: () {
        return Center(
          child: CircularProgressIndicator.adaptive(),
        );
      })),
    );
  }
}

class EmployeeListError extends StatelessWidget {
  const EmployeeListError({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(PhosphorIcons.warning(PhosphorIconsStyle.bold)),
          Text(
            "Something went wrong\nPlease try again later",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}

class EmployeeListEmpty extends StatelessWidget {
  const EmployeeListEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(PhosphorIcons.warning(PhosphorIconsStyle.bold)),
          Text(
            "No employee found",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}
