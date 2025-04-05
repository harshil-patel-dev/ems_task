import 'package:bloc/bloc.dart';
import 'package:ems_task/core/database/hive_helper.dart';
import 'package:ems_task/core/models/employee_model.dart';
import 'package:ems_task/core/utils/validator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:formz/formz.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeFormEvent, EmployeeFormState> {
  EmployeeBloc({Employee? employee}) : super(EmployeeFormState()) {
    if (employee != null) {
      final name = EmpName.dirty(employee.name);
      final role = EmpRole.dirty(employee.role);
      final fromDate = FromDate.dirty(employee.fromDate);
      final toDate = ToDate.dirty(employee.toDate);

      emit(
        state.copyWith(
          name: name,
          role: role,
          fromDate: fromDate,
          toDate: toDate,
          employeeId: employee.id,
          isEditing: true,
          isFormValid: Formz.validate([name, role, fromDate, toDate]),
        ),
      );
    }

    on<NameChanged>((event, emit) {
      final name = EmpName.dirty(event.name);
      emit(state.copyWith(name: name, isFormValid: Formz.validate([name])));
    });

    on<RoleChanged>((event, emit) {
      final role = EmpRole.dirty(event.role);
      emit(state.copyWith(role: role, isFormValid: Formz.validate([role])));
    });

    on<FromDateChanged>((event, emit) {
      final fromDate = FromDate.dirty(event.date);
      emit(
        state.copyWith(
          fromDate: fromDate,
          isFormValid: Formz.validate([fromDate]),
        ),
      );
    });

    on<ToDateChanged>((event, emit) {
      final toDate = ToDate.dirty(event.date);
      emit(
        state.copyWith(toDate: toDate, isFormValid: Formz.validate([toDate])),
      );
    });

    on<SaveEmployeeDetails>((event, emit) async {
      final name = EmpName.dirty(state.name.value);
      final role = EmpRole.dirty(state.role.value);
      final fromDate = FromDate.dirty(state.fromDate.value);
      final toDate = ToDate.dirty(state.toDate.value);
      final status = Formz.validate([name, role, fromDate, toDate]);

      emit(
        state.copyWith(
          name: name,
          role: role,
          fromDate: fromDate,
          toDate: toDate,
          isFormValid: status,
        ),
      );

      if (state.isFormValid) {
        final employee = Employee(
          id: state.employeeId ?? UniqueKey().toString(),
          name: name.value,
          role: role.value,
          fromDate: fromDate.value!,
          toDate: toDate.value,
        );

        if (state.isEditing) {
          await HiveHelper.updateEmployee(employee);
        } else {
          await HiveHelper.addEmployee(employee);
        }

        emit(state.copyWith(status: FormzSubmissionStatus.success));
      }
    });
  }
}
