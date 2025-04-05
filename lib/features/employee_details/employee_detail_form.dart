import 'package:ems_task/core/constants/app_constants.dart';
import 'package:ems_task/core/models/employee_model.dart';
import 'package:ems_task/core/utils/app_export.dart';
import 'package:ems_task/core/models/quickdate_model.dart';
import 'package:ems_task/core/utils/validator.dart';
import 'package:ems_task/features/employee_details/bloc/employee_bloc.dart';
import 'package:ems_task/features/home/bloc/home_bloc.dart';
import 'package:ems_task/widgets/custom_button.dart';
import 'package:ems_task/widgets/custom_datepicker.dart';
import 'package:ems_task/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class EmployeeDetailForm extends StatefulWidget {
  final Employee? employee;
  const EmployeeDetailForm({super.key, this.employee});

  @override
  State<EmployeeDetailForm> createState() => _EmployeeDetailFormState();
}

class _EmployeeDetailFormState extends State<EmployeeDetailForm> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.employee?.name ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeeBloc(employee: widget.employee),
      child: BlocConsumer<EmployeeBloc, EmployeeFormState>(
        listener: (context, state) {
          if (state.name.value != _nameController.text) {
            _nameController.text = state.name.value;
          }

          if (state.status == FormzSubmissionStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.isEditing
                      ? 'Employee details updated successfully'
                      : 'Employee details saved successfully',
                ),
                duration: Duration(seconds: 2),
              ),
            );
            context.read<HomeBloc>().add(FetchEmployees());
            context.pop();
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                state.isEditing
                    ? AppStrings.editEmpTitle
                    : AppStrings.addEmpTitle,
              ),
              automaticallyImplyLeading: false,
              centerTitle: false,
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      leadingIcon: Icons.person_outline_rounded,
                      hint: AppStrings.empName,
                      errorText:
                          !state.isFormValid &&
                                  state.name.error ==
                                      EmpNameValidationError.empty
                              ? AppStrings.empNameError
                              : null,
                      onChanged:
                          (value) => context.read<EmployeeBloc>().add(
                            NameChanged(value),
                          ),
                      controller: _nameController,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      leadingIcon: Icons.work_outline_rounded,
                      hint: AppStrings.role,
                      trailingIcon: Icons.arrow_drop_down,
                      readOnly: true,
                      onTap: () => _showRoleBottomSheet(context),
                      controller: TextEditingController(
                        text:
                            state.role.value.isNotEmpty ? state.role.value : '',
                      ),
                      errorText:
                          !state.isFormValid &&
                                  state.role.error ==
                                      EmpRoleValidationError.empty
                              ? AppStrings.empRoleError
                              : null,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: CustomTextField(
                            leadingIcon: Icons.calendar_month_outlined,
                            hint: AppStrings.fromDate,
                            readOnly: true,
                            controller: TextEditingController(
                              text:
                                  state.fromDate.value != null
                                      ? _getFormattedDate(state.fromDate.value!)
                                      : '',
                            ),
                            errorText:
                                !state.isFormValid &&
                                        state.fromDate.error ==
                                            FromDateValidationError.invalid
                                    ? AppStrings.empFromDateError
                                    : null,
                            onTap:
                                () => _showCustomDatePicker(
                                  context,
                                  onDateSelected: (DateTime? date) {
                                    context.read<EmployeeBloc>().add(
                                      FromDateChanged(date),
                                    );
                                  },
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
                                            (DateTime.monday -
                                                now.weekday +
                                                7) %
                                            7;
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
                                            (DateTime.tuesday -
                                                now.weekday +
                                                7) %
                                            7;
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
                          child: CustomTextField(
                            leadingIcon: Icons.calendar_month_outlined,
                            hint: AppStrings.toDate,
                            readOnly: true,
                            controller: TextEditingController(
                              text:
                                  state.toDate.value != null
                                      ? _getFormattedDate(state.toDate.value!)
                                      : '',
                            ),

                            onTap:
                                () => _showCustomDatePicker(
                                  context,
                                  onDateSelected: (DateTime? date) {
                                    context.read<EmployeeBloc>().add(
                                      ToDateChanged(date),
                                    );
                                  },

                                  minDate: state.fromDate.value,
                                  quickDateOptions: [
                                    QuickDateOption(
                                      isNoDate: true,
                                      text: 'No date',
                                      getDate: () {
                                        context.read<EmployeeBloc>().add(
                                          ToDateChanged(null),
                                        );
                                        return DateTime(0);
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
                      text:
                          state.isEditing ? AppStrings.update : AppStrings.save,
                      onPressed: () {
                        context.read<EmployeeBloc>().add(SaveEmployeeDetails());
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _showRoleBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext ctx) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ListView.separated(
            shrinkWrap: true,
            itemBuilder:
                (listCtx, index) => ListTile(
                  title: Text(
                    employeeRoles[index],
                    style: AppStyles.bodyText(),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    context.read<EmployeeBloc>().add(
                      RoleChanged(employeeRoles[index]),
                    );
                    context.pop();
                  },
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
    List<QuickDateOption>? quickDateOptions,
    required Function(DateTime?) onDateSelected,
    DateTime? minDate,
    DateTime? maxDate,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: CustomDatePicker(
            onDateSelected: (DateTime? date) => onDateSelected(date),
            quickDateOptions: quickDateOptions,
            minDate: minDate,
            maxDate: maxDate,
          ),
        );
      },
    );
  }

  String _getFormattedDate(DateTime date) {
    if (date == DateTime(0)) {
      return 'No date';
    }
    if (date.year == DateTime.now().year &&
        date.month == DateTime.now().month &&
        date.day == DateTime.now().day) {
      return 'Today';
    }
    return DateFormat(dateFormat).format(date);
  }
}
