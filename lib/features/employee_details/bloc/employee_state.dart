part of 'employee_bloc.dart';

class EmployeeFormState extends Equatable {
  final EmpName name;
  final EmpRole role;
  final FromDate fromDate;
  final ToDate toDate;
  final bool isFormValid;
  final FormzSubmissionStatus status;
  final String? employeeId;
  final bool isEditing;

  const EmployeeFormState({
    this.name = const EmpName.pure(),
    this.role = const EmpRole.pure(),
    this.fromDate = const FromDate.pure(),
    this.toDate = const ToDate.pure(),
    this.isFormValid = true,
    this.status = FormzSubmissionStatus.initial,
    this.employeeId,
    this.isEditing = false,
  });

  EmployeeFormState copyWith({
    EmpName? name,
    EmpRole? role,
    FromDate? fromDate,
    ToDate? toDate,
    bool? isFormValid,
    FormzSubmissionStatus? status,
    String? employeeId,
    bool? isEditing,
  }) {
    return EmployeeFormState(
      name: name ?? this.name,
      role: role ?? this.role,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      isFormValid: isFormValid ?? this.isFormValid,
      status: status ?? this.status,
      employeeId: employeeId ?? this.employeeId,
      isEditing: isEditing ?? this.isEditing,
    );
  }

  @override
  List<Object?> get props => [
    name,
    role,
    fromDate,
    toDate,
    isFormValid,
    status,
    employeeId,
    isEditing,
  ];
}
