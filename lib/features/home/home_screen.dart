import 'package:ems_task/core/utils/app_export.dart';
import 'package:ems_task/features/home/models/employee_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final employees = mockEmployees;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.homeTitle),
        centerTitle: false,
      ),
      body: SafeArea(
        child:
            employees.isNotEmpty
                ? _buildEmployeeList(employees)
                : _buildEmptyState(),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onPressed: () {
          context.pushNamed(RouteNames.addEmployee);
        },
        child: const Icon(Icons.add, size: 30),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppAssets.noRecordsImage,
            height: 200,
            fit: BoxFit.fitHeight,
          ),
          const SizedBox(height: 5),
          Text(
            AppStrings.noRecordsText,
            style: AppStyles.title(color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeeList(List<Employee> employees) {
    final currentEmployees =
        employees.where((e) => e.isCurrentEmployee).toList();
    final previousEmployees =
        employees.where((e) => !e.isCurrentEmployee).toList();

    return ListView(
      children: [
        // Current employees section
        Container(
          color: AppColors.lightGray,
          padding: const EdgeInsets.all(16),
          child: Text(
            AppStrings.currentEmp,
            style: AppStyles.subtitle(color: AppColors.primary),
          ),
        ),
        // Current employees list items
        ...currentEmployees.map(
          (employee) => Column(
            children: [
              _buildEmployeeItem(employee),
              if (employee != currentEmployees.last)
                const Divider(height: 2, color: AppColors.lightGray),
            ],
          ),
        ),

        // Previous employees section
        Container(
          color: AppColors.lightGray,
          padding: const EdgeInsets.all(16),
          margin: EdgeInsets.only(top: currentEmployees.isNotEmpty ? 16 : 0),
          child: Text(
            AppStrings.previousEmp,
            style: AppStyles.subtitle(color: AppColors.primary),
          ),
        ),

        // Previous employees list items
        ...previousEmployees.map(
          (employee) => Column(
            children: [
              _buildEmployeeItem(employee),
              if (employee != previousEmployees.last)
                const Divider(height: 2, color: AppColors.lightGray),
            ],
          ),
        ),

        // Swipe instruction
        Container(
          color: AppColors.lightGray,
          padding: const EdgeInsets.all(16),
          margin: EdgeInsets.only(top: currentEmployees.isNotEmpty ? 16 : 0),
          child: Text(
            AppStrings.deleteText,
            style: AppStyles.bodyText(color: AppColors.grey),
          ),
        ),
      ],
    );
  }

  Widget _buildEmployeeItem(Employee employee) {
    return SizedBox(
      width: double.infinity,
      child: Dismissible(
        key: Key(employee.id),
        direction: DismissDirection.endToStart,
        background: Container(
          color: AppColors.error,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 16),
          child: const Icon(
            Icons.delete_outline_outlined,
            color: Colors.white,
            size: 24,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(employee.name, style: AppStyles.subtitle()),
              const SizedBox(height: 4),
              Text(employee.role, style: AppStyles.descText()),
              const SizedBox(height: 4),
              Text(
                employee.dateRangeText,
                style: AppStyles.descText().copyWith(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
