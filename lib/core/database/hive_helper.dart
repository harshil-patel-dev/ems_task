import 'package:hive_flutter/hive_flutter.dart';
import 'package:ems_task/core/models/employee_model.dart';

class HiveHelper {
  static const String employeeBoxName = 'employees';

  // Initialize Hive
  static Future<void> init() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(EmployeeAdapter());
    }

    await Hive.openBox<Employee>(employeeBoxName);
  }

  static Box<Employee> getEmployeeBox() {
    return Hive.box<Employee>(employeeBoxName);
  }

  static Future<void> addEmployee(Employee employee) async {
    final box = getEmployeeBox();
    await box.put(employee.id, employee);
  }

  static List<Employee> getAllEmployees() {
    final box = getEmployeeBox();
    return box.values.toList();
  }

  static Future<void> updateEmployee(Employee employee) async {
    final box = await Hive.openBox<Employee>(employeeBoxName);
    await box.put(employee.id, employee);
  }

  static Future<void> deleteEmployee(String id) async {
    final box = getEmployeeBox();
    await box.delete(id);
  }
}
