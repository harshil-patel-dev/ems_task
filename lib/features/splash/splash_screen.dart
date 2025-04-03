import 'package:ems_task/core/router/app_routes.dart';
import 'package:ems_task/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 1), () async {
          if (context.mounted) {
            context.goNamed(RouteNames.home);
          }
        }),
        builder: (context, snapshot) {
          return Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'EMS',
                  style: TextStyle(
                    fontSize: 60,

                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 100,
                  child: LinearProgressIndicator(
                    minHeight: 4,
                    backgroundColor: AppColors.secondary,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
