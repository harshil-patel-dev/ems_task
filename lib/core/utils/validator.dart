import 'package:formz/formz.dart';

enum EmpNameValidationError { empty }

class EmpName extends FormzInput<String, EmpNameValidationError> {
  const EmpName.pure() : super.pure('');
  const EmpName.dirty([String value = '']) : super.dirty(value);

  @override
  EmpNameValidationError? validator(String value) {
    return value.isNotEmpty ? null : EmpNameValidationError.empty;
  }
}

enum EmpRoleValidationError { empty }

class EmpRole extends FormzInput<String, EmpRoleValidationError> {
  const EmpRole.pure() : super.pure('');
  const EmpRole.dirty([String value = '']) : super.dirty(value);

  @override
  EmpRoleValidationError? validator(String value) {
    return value.isNotEmpty ? null : EmpRoleValidationError.empty;
  }
}

enum FromDateValidationError { invalid }

class FromDate extends FormzInput<DateTime?, FromDateValidationError> {
  const FromDate.pure() : super.pure(null);
  const FromDate.dirty([DateTime? value]) : super.dirty(value);

  @override
  FromDateValidationError? validator(DateTime? value) {
    return value == null ? FromDateValidationError.invalid : null;
    // return value.isAfter(DateTime(1900)) ? null : FromDateValidationError.invalid;
  }
}

enum ToDateValidationError { invalid }

class ToDate extends FormzInput<DateTime?, ToDateValidationError> {
  const ToDate.pure() : super.pure(null);
  const ToDate.dirty([DateTime? value]) : super.dirty(value);

  @override
  ToDateValidationError? validator(DateTime? value) {
    return null;
  }
}
