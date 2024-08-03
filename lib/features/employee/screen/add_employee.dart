import 'package:cosmocloud/constants/size.dart';
import 'package:cosmocloud/core/failure.dart';
import 'package:cosmocloud/core/widget/appbar.dart';
import 'package:cosmocloud/core/widget/button.dart';
import 'package:cosmocloud/core/widget/text_field.dart';
import 'package:cosmocloud/features/employee/employee_controller.dart';
import 'package:cosmocloud/model/employee.dart';
import 'package:cosmocloud/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AddEmployeeScreen extends ConsumerWidget {
  const AddEmployeeScreen({super.key});

  static route() {
    return MaterialPageRoute(
      builder: (context) => const AddEmployeeScreen(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(employeeControllerProvider.select((value) => value.addEmployee),
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

    final _formKey = GlobalKey<FormState>();
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _phoneController = TextEditingController();
    final TextEditingController _addressController = TextEditingController();
    final TextEditingController _cityController = TextEditingController();
    final TextEditingController _zipController = TextEditingController();
    final TextEditingController _countryController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(title: "Add Employee"),
      ),
      body: Container(
        margin: EdgeInsets.all(AppSize.smallSpace * 1.5),
        child: Column(
          children: [
            Expanded(
                child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomTextField(
                      icon: PhosphorIcons.user(),
                      hintText: "Name",
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return "Name cannot be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: AppSize.smallSpace,
                    ),
                    CustomTextField(
                      icon: PhosphorIcons.boxArrowDown(),
                      hintText: "Email",
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Email cannot be empty";
                        }
                        final emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                        if (!RegExp(emailRegex).hasMatch(value)) {
                          return "Invalid email address";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: AppSize.smallSpace,
                    ),
                    CustomTextField(
                      icon: PhosphorIcons.phone(),
                      hintText: "Phone",
                      controller: _phoneController,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return "Number cannot be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: AppSize.smallSpace,
                    ),
                    CustomTextField(
                      icon: PhosphorIcons.mapPinLine(),
                      hintText: "Address Line 1",
                      controller: _addressController,
                      keyboardType: TextInputType.streetAddress,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return "Address cannot be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: AppSize.smallSpace,
                    ),
                    CustomTextField(
                      icon: PhosphorIcons.city(),
                      hintText: "City",
                      controller: _cityController,
                      keyboardType: TextInputType.text,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return "City cannot be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: AppSize.smallSpace,
                    ),
                    CustomTextField(
                      icon: PhosphorIcons.numpad(),
                      hintText: "Zip Code",
                      controller: _zipController,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return "Zip code cannot be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: AppSize.smallSpace,
                    ),
                    CustomTextField(
                      icon: PhosphorIcons.globeHemisphereEast(),
                      hintText: "Country",
                      controller: _countryController,
                      keyboardType: TextInputType.text,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return "Country cannot be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: AppSize.smallSpace,
                    ),
                  ],
                ),
              ),
            )),
            Padding(
              padding: const EdgeInsets.only(top: AppSize.smallSpace),
              child: LargeButton(
                  isDisable: ref.watch(employeeControllerProvider
                      .select((value) => value.addEmployee)) is AsyncLoading,
                  isLoading: ref.watch(employeeControllerProvider
                      .select((value) => value.addEmployee)) is AsyncLoading,
                  text: Text(
                    "Add Employee",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontFamily: "CircularStd-Medium", color: Palette.white),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ref.read(employeeControllerProvider.notifier).addEmployee(
                              employee: Employee(
                                  id: "",
                                  name: _nameController.text,
                                  address: Address(
                                      line1: _addressController.text,
                                      city: _cityController.text,
                                      country: _countryController.text,
                                      zip_code: int.parse(_zipController.text)),
                                  contact: [
                                ContactObject(
                                  type: "email",
                                  value: _emailController.text,
                                ),
                                ContactObject(
                                  type: "phone",
                                  value: _phoneController.text,
                                )
                              ]));
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
