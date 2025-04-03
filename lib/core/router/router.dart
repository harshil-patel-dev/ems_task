import 'package:ems_task/core/router/app_routes.dart';
import 'package:ems_task/core/router/view/error_route_view.dart';
import 'package:ems_task/features/employee_details/employee_detail_form.dart';
import 'package:ems_task/features/home/home_screen.dart';
import 'package:ems_task/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  late final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: RouteNames.initial,
    errorPageBuilder:
        (context, state) =>
            MaterialPage(key: state.pageKey, child: const ErrorRouteView()),
    routes: [
      GoRoute(
        name: RouteNames.initial,
        path: RouteNames.initial,
        pageBuilder:
            (context, state) =>
                MaterialPage(key: state.pageKey, child: const SplashScreen()),
      ),
      GoRoute(
        name: RouteNames.home,
        path: RouteNames.home,
        pageBuilder:
            (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: HomeScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(opacity: animation, child: child),
            ),
      ),
      GoRoute(
        name: RouteNames.addEmployee,
        path: RouteNames.addEmployee,
        pageBuilder:
            (context, state) => MaterialPage(child: EmployeeDetailForm()),
      ),
    ],
  );
}
