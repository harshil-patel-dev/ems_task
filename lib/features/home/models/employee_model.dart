class Employee {
  final String id;
  final String name;
  final String role;
  final DateTime fromDate;
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
    final fromDateFormatted =
        '${fromDate.day} ${_getMonthName(fromDate.month)}, ${fromDate.year}';

    if (toDate == null) {
      return 'From $fromDateFormatted';
    } else {
      final toDateFormatted =
          '${toDate!.day} ${_getMonthName(toDate!.month)}, ${toDate!.year}';
      return '$fromDateFormatted - $toDateFormatted';
    }
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }
}

List<Employee> get mockEmployees => [
  // Current employees
  Employee(
    id: '1',
    name: 'Samantha Lee',
    role: 'Full-stack Developer',
    fromDate: DateTime(2022, 9, 21),
  ),
  Employee(
    id: '2',
    name: 'David Kim',
    role: 'Senior Software developer',
    fromDate: DateTime(2022, 7, 1),
  ),
  Employee(
    id: '3',
    name: 'Sarah Johnson',
    role: 'Senior Software developer',
    fromDate: DateTime(2022, 6, 14),
  ),

  // Previous employees
  Employee(
    id: '4',
    name: 'Emily Davis',
    role: 'Full-stack Developer',
    fromDate: DateTime(2022, 9, 21),
    toDate: DateTime(2023, 1, 1),
  ),
  Employee(
    id: '5',
    name: 'Jason Patel',
    role: 'Senior Software developer',
    fromDate: DateTime(2022, 7, 1),
    toDate: DateTime(2022, 12, 31),
  ),
  Employee(
    id: '6',
    name: 'Rachel Nguyen',
    role: 'Senior Software developer',
    fromDate: DateTime(2022, 7, 1),
    toDate: DateTime(2023, 12, 22),
  ),
];
