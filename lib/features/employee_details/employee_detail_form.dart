import 'package:ems_task/core/constants/app_constants.dart';
import 'package:ems_task/core/utils/app_export.dart';
import 'package:ems_task/features/employee_details/models/quickdate_model.dart';
import 'package:ems_task/widgets/custom_button.dart';
import 'package:ems_task/widgets/custom_datepicker.dart';
import 'package:ems_task/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class EmployeeDetailForm extends StatefulWidget {
  const EmployeeDetailForm({super.key});

  @override
  State<EmployeeDetailForm> createState() => _EmployeeDetailFormState();
}

class _EmployeeDetailFormState extends State<EmployeeDetailForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _roleController.dispose();
    _fromDateController.dispose();
    _toDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.addEmpTitle),
        automaticallyImplyLeading: false,
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFormField(
                leadingIcon: Icons.person_outline_rounded,
                hint: AppStrings.empName,
                controller: _nameController,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                leadingIcon: Icons.work_outline_rounded,
                hint: AppStrings.role,
                trailingIcon: Icons.arrow_drop_down,
                controller: _roleController,
                readOnly: true,
                onTap: () => _showRoleBottomSheet(context),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      leadingIcon: Icons.calendar_month_outlined,
                      hint: AppStrings.fromDate,
                      controller: _fromDateController,
                      readOnly: true,
                      onTap:
                          () => _showCustomDatePicker(
                            context,
                            controller: _fromDateController,
                            quickDateOptions: [
                              QuickDateOption(
                                text: 'Today',
                                getDate: () => DateTime.now(),
                              ),
                              QuickDateOption(
                                text: 'Next Monday',
                                getDate: () {
                                  final now = DateTime.now();
                                  final daysUntilNextMonday =
                                      (DateTime.monday - now.weekday + 7) % 7;
                                  return now.add(
                                    Duration(days: daysUntilNextMonday),
                                  );
                                },
                              ),
                              QuickDateOption(
                                text: 'Next Tuesday',
                                getDate: () {
                                  final now = DateTime.now();
                                  final daysUntilNextTuesday =
                                      (DateTime.tuesday - now.weekday + 7) % 7;
                                  return now.add(
                                    Duration(days: daysUntilNextTuesday),
                                  );
                                },
                              ),
                              QuickDateOption(
                                text: 'After 1 week',
                                getDate:
                                    () => DateTime.now().add(
                                      const Duration(days: 7),
                                    ),
                              ),
                            ],
                          ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Icon(Icons.arrow_forward),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomTextFormField(
                      leadingIcon: Icons.calendar_month_outlined,
                      hint: AppStrings.toDate,
                      controller: _toDateController,
                      readOnly: true,
                      onTap:
                          () => _showCustomDatePicker(
                            context,
                            controller: _toDateController,
                            quickDateOptions: [
                              QuickDateOption(
                                text: 'No date',
                                getDate: () {
                                  return DateTime.now();
                                },
                              ),
                              QuickDateOption(
                                text: 'Today',
                                getDate: () => DateTime.now(),
                              ),
                            ],
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                type: ButtonType.secondary,
                text: AppStrings.cancel,
                onPressed: () {
                  context.pop();
                },
              ),
              const SizedBox(width: 16),
              CustomButton(
                type: ButtonType.primary,
                text: AppStrings.save,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showRoleBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ListView.separated(
            shrinkWrap: true,
            itemBuilder:
                (context, index) => ListTile(
                  title: Text(
                    employeeRoles[index],
                    style: AppStyles.bodyText(),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {},
                ),
            separatorBuilder:
                (context, index) => Divider(color: AppColors.greyLight),
            itemCount: employeeRoles.length,
          ),
        );
      },
    );
  }

  void _showCustomDatePicker(
    BuildContext context, {
    required TextEditingController controller,
    List<QuickDateOption>? quickDateOptions,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: CustomDatePicker(
            onDateSelected: (DateTime? date) {
              setState(() {
                if (date == null) {
                  controller.text = 'No date';
                } else {
                  controller.text = DateFormat('d MMM yyyy').format(date);
                }
              });
            },
            quickDateOptions: quickDateOptions,
          ),
        );
      },
    );
  }
}
