import 'package:ems_task/core/constants/app_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

part 'employee_model.g.dart'; // Ensure this line is present

@HiveType(typeId: 0)
class Employee extends Equatable {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String role;

  @HiveField(3)
  final DateTime fromDate;

  @HiveField(4)
  final DateTime? toDate;

  Employee({
    required this.id,
    required this.name,
    required this.role,
    required this.fromDate,
    this.toDate,
  });

  bool get isCurrentEmployee => toDate == null;

  String get dateRangeText {
    if (toDate == null) {
      return 'From ${DateFormat('d MMM, yyyy').format(fromDate)}';
    } else {
      return '${DateFormat('d MMM, yyyy').format(fromDate)} - ${DateFormat('d MMM, yyyy').format(toDate!)}';
    }
  }

  @override
  List<Object?> get props => [id, name, role, fromDate, toDate];
}

// List<Employee> get mockEmployees => [
//   // Current employees
//   Employee(
//     id: '1',
//     name: 'Samantha Lee',
//     role: 'Full-stack Developer',
//     fromDate: DateTime(2022, 9, 21),
//   ),
//   Employee(
//     id: '2',
//     name: 'David Kim',
//     role: 'Senior Software developer',
//     fromDate: DateTime(2022, 7, 1),
//   ),
//   Employee(
//     id: '3',
//     name: 'Sarah Johnson',
//     role: 'Senior Software developer',
//     fromDate: DateTime(2022, 6, 14),
//   ),

//   // Previous employees
//   Employee(
//     id: '4',
//     name: 'Emily Davis',
//     role: 'Full-stack Developer',
//     fromDate: DateTime(2022, 9, 21),
//     toDate: DateTime(2023, 1, 1),
//   ),
//   Employee(
//     id: '5',
//     name: 'Jason Patel',
//     role: 'Senior Software developer',
//     fromDate: DateTime(2022, 7, 1),
//     toDate: DateTime(2022, 12, 31),
//   ),
//   Employee(
//     id: '6',
//     name: 'Rachel Nguyen',
//     role: 'Senior Software developer',
//     fromDate: DateTime(2022, 7, 1),
//     toDate: DateTime(2023, 12, 22),
//   ),
// ];
