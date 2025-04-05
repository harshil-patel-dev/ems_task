part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class FetchEmployees extends HomeEvent {}

final class DeleteEmployee extends HomeEvent {
  final String empID;
  DeleteEmployee({required this.empID});
}
