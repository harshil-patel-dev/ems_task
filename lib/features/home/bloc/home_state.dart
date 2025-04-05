// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object> get props => [];
}

class EmployeeLoading extends HomeState {
  const EmployeeLoading();
  @override
  List<Object> get props => [];
}

class EmployeeLoaded extends HomeState {
  final List<Employee> currentEmployees;
  final List<Employee> previousEmployees;
  final FormzSubmissionStatus deleteStatus;
  const EmployeeLoaded({
    required this.currentEmployees,
    required this.previousEmployees,
    this.deleteStatus = FormzSubmissionStatus.initial,
  });
  @override
  List<Object> get props => [currentEmployees, previousEmployees];

  EmployeeLoaded copyWith({
    List<Employee>? currentEmployees,
    List<Employee>? previousEmployees,
    FormzSubmissionStatus? deleteStatus,
  }) {
    return EmployeeLoaded(
      currentEmployees: currentEmployees ?? this.currentEmployees,
      previousEmployees: previousEmployees ?? this.previousEmployees,
      deleteStatus: deleteStatus?? this.deleteStatus,
    );
  }
}

class EmployeeEmpty extends HomeState {
  const EmployeeEmpty();
  @override
  List<Object> get props => [];
}

class EmployeeError extends HomeState {
  final String message;
  const EmployeeError({required this.message});
  @override
  List<Object> get props => [message];
}
