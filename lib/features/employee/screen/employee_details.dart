import 'package:cosmocloud/constants/size.dart';
import 'package:cosmocloud/core/failure.dart';
import 'package:cosmocloud/core/widget/appbar.dart';
import 'package:cosmocloud/core/widget/button.dart';
import 'package:cosmocloud/features/employee/employee_controller.dart';
import 'package:cosmocloud/model/employee.dart';
import 'package:cosmocloud/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class EmployeeDetailsScreen extends ConsumerWidget {
  final Employee employee;
  const EmployeeDetailsScreen({super.key, required this.employee});

  static route(Employee employee) {
    return MaterialPageRoute(
      builder: (context) => EmployeeDetailsScreen(employee: employee),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
        employeeControllerProvider.select((value) => value.deleteEmployee),
        (prev, next) {
      next.when(
          data: (value) {
            if (value == true) {
              Navigator.of(context).pop();
            }
          },
          error: (e, s) {
            showErrorToast(
                context: context, message: e.toString(), duration: 3);
          },
          loading: () {});
    });
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(title: employee.name),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSize.smallSpace * 1.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    border: Border.all(
                      color: Palette.blue,
                      width: 1,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      employee.name[0],
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontFamily: "CircularStd-Medium",
                            fontSize: 50,
                          ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSize.smallSpace),
              Center(
                child: Text(
                  employee.name,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontFamily: "CircularStd-Medium",
                      ),
                ),
              ),
              const SizedBox(height: AppSize.mediumSpace),
              Text(
                "Contact",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontFamily: "CircularStd-Medium",
                    ),
              ),
              const SizedBox(height: AppSize.smallSpace),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSize.smallSpace * 1.5,
                  vertical: AppSize.smallSpace,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius:
                      BorderRadius.circular(AppSize.mediumBorderRadius),
                ),
                child: Column(
                  children: employee.contact.map((e) {
                    return Column(
                      children: [
                        CustomeListTile(
                          title: e.value,
                          subtitle: e.type,
                          icon: e.type == "email"
                              ? PhosphorIcons.boxArrowDown()
                              : PhosphorIcons.phone(),
                        ),
                        if (employee.contact.last != e)
                          const SizedBox(height: AppSize.smallSpace),
                      ],
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: AppSize.mediumSpace),
              Text(
                "Address",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontFamily: "CircularStd-Medium",
                    ),
              ),
              const SizedBox(height: AppSize.smallSpace),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSize.smallSpace * 1.5,
                  vertical: AppSize.smallSpace,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius:
                      BorderRadius.circular(AppSize.mediumBorderRadius),
                ),
                child: Column(
                  children: [
                    CustomeListTile(
                        title: employee.address.line1,
                        subtitle: "Line 1",
                        icon: PhosphorIcons.mapPin()),
                    const SizedBox(height: AppSize.smallSpace),
                    CustomeListTile(
                        title: employee.address.city,
                        subtitle: "City",
                        icon: PhosphorIcons.city()),
                    const SizedBox(height: AppSize.smallSpace),
                    CustomeListTile(
                        title: employee.address.zip_code.toString(),
                        subtitle: "Zip Code",
                        icon: PhosphorIcons.numpad()),
                    const SizedBox(height: AppSize.smallSpace),
                    CustomeListTile(
                        title: employee.address.country,
                        subtitle: "Country",
                        icon: PhosphorIcons.globeHemisphereEast()),
                  ],
                ),
              ),
              SizedBox(height: AppSize.mediumSpace),
              LargeButton(
                isDisable: ref.watch(employeeControllerProvider
                    .select((value) => value.deleteEmployee)) is AsyncLoading,
                isLoading: ref.watch(employeeControllerProvider
                    .select((value) => value.deleteEmployee)) is AsyncLoading,
                onPressed: () {
                  ref.read(employeeControllerProvider.notifier).deleteEmployee(
                        employee.id,
                      );
                },
                text: Text(
                  "Delete",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontFamily: "CircularStd-Medium",
                        color: Palette.white,
                      ),
                ),
                color: Palette.red,
              ),
              SizedBox(height: AppSize.smallSpace),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomeListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  const CustomeListTile(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            icon,
            color: Palette.blue,
          ),
        ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(fontFamily: "CircularStd-Medium", color: Palette.grey),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontFamily: "CircularStd-Medium",
            ),
      ),
    );
  }
}
