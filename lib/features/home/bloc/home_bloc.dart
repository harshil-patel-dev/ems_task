import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:ems_task/core/database/hive_helper.dart';
import 'package:ems_task/core/models/employee_model.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(EmployeeLoading()) {
    on<FetchEmployees>((event, emit) async {
      try {
        final employees = HiveHelper.getAllEmployees();
        if (employees.isNotEmpty) {
          emit(
            EmployeeLoaded(
              currentEmployees:
                  employees
                      .where((element) => element.isCurrentEmployee)
                      .toList(),
              previousEmployees:
                  employees
                      .where((element) => !element.isCurrentEmployee)
                      .toList(),
            ),
          );
        } else {
          emit(EmployeeEmpty());
        }
      } catch (e) {
        emit(EmployeeError(message: e.toString()));
      }
    });
    on<DeleteEmployee>((event, emit) async {
      if (state is EmployeeLoaded) {
        final currentState = state as EmployeeLoaded;
        emit(
          currentState.copyWith(deleteStatus: FormzSubmissionStatus.inProgress),
        );

        try {
          await HiveHelper.deleteEmployee(event.empID);
          emit(
            currentState.copyWith(deleteStatus: FormzSubmissionStatus.success),
          );
          add(FetchEmployees());
        } catch (e) {
          emit(
            currentState.copyWith(deleteStatus: FormzSubmissionStatus.failure),
          );
        }
      }
    });
  }
}
