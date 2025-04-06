import 'package:ems_task/core/utils/app_export.dart';
import 'package:ems_task/core/models/employee_model.dart';
import 'package:ems_task/features/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.homeTitle),
        centerTitle: false,
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => context.read<HomeBloc>()..add(FetchEmployees()),
          child: RefreshIndicator(
            onRefresh: () async {
              context.read<HomeBloc>().add(FetchEmployees());
            },
            child: BlocConsumer<HomeBloc, HomeState>(
              listener: (context, state) {
                if (state is EmployeeLoaded &&
                    state.deleteStatus == FormzSubmissionStatus.success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Employee data has been deleted'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is EmployeeLoading) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else if (state is EmployeeLoaded) {
                  return _buildEmployeeList();
                } else if (state is EmployeeEmpty) {
                  return _buildEmptyState();
                } else {
                  return const Center(
                    child: Text('Something went wrong. Please try again.'),
                  );
                }
              },
            ),
          ),
        ),
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

  Widget _buildEmployeeList() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
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

            if ((state as EmployeeLoaded).currentEmployees.isEmpty)
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Center(
                  child: Text(
                    AppStrings.noCurrEmpFoundText,
                    style: AppStyles.bodyText(color: AppColors.grey),
                  ),
                ),
              )
            else
              ...state.currentEmployees.map(
                (employee) => Column(
                  children: [
                    _buildEmployeeItem(context, employee),
                    if (employee != state.currentEmployees.last)
                      const Divider(height: 2, color: AppColors.lightGray),
                  ],
                ),
              ),

            // Previous employees section
            Container(
              color: AppColors.lightGray,
              padding: const EdgeInsets.all(16),
              margin: EdgeInsets.only(
                top: state.currentEmployees.isNotEmpty ? 16 : 0,
              ),
              child: Text(
                AppStrings.previousEmp,
                style: AppStyles.subtitle(color: AppColors.primary),
              ),
            ),

            if (state.previousEmployees.isEmpty)
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Center(
                  child: Text(
                    AppStrings.noPrevEmpFoundText,
                    style: AppStyles.bodyText(color: AppColors.grey),
                  ),
                ),
              )
            else
              ...state.previousEmployees.map(
                (employee) => Column(
                  children: [
                    _buildEmployeeItem(context, employee),
                    if (employee != state.previousEmployees.last)
                      const Divider(height: 2, color: AppColors.lightGray),
                  ],
                ),
              ),

            // Swipe instruction
            Container(
              color: AppColors.lightGray,
              padding: const EdgeInsets.all(16),
              margin: EdgeInsets.only(
                top: state.currentEmployees.isNotEmpty ? 16 : 0,
              ),
              child: Text(
                AppStrings.deleteText,
                style: AppStyles.bodyText(color: AppColors.grey),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEmployeeItem(BuildContext context, Employee employee) {
    return InkWell(
      onTap: () {
        context.pushNamed(RouteNames.editEmployee, extra: employee);
      },
      child: SizedBox(
        width: double.infinity,
        child: Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) {
            context.read<HomeBloc>().add(DeleteEmployee(empID: employee.id));
          },
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
      ),
    );
  }
}
