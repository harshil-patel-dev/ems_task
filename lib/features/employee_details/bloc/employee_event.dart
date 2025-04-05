part of 'employee_bloc.dart';

@immutable
sealed class EmployeeFormEvent {}

class NameChanged extends EmployeeFormEvent {
  final String name;
  NameChanged(this.name);
}

class RoleChanged extends EmployeeFormEvent {
  final String role;
  RoleChanged(this.role);
}

class FromDateChanged extends EmployeeFormEvent {
  final DateTime? date;
  FromDateChanged(this.date);
}

class ToDateChanged extends EmployeeFormEvent {
  final DateTime? date;
  ToDateChanged(this.date);
}

class SaveEmployeeDetails extends EmployeeFormEvent {}
