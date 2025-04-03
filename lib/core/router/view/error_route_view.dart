import 'package:flutter/material.dart';

class ErrorRouteView extends StatelessWidget {
  const ErrorRouteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Error icon
            const Icon(
              Icons.error_outline,
              size: 100,
              color: Colors.red,
            ),
            const SizedBox(height: 20),
            // Error message
            const Text(
              'Oops! Page Not Found',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'The page you are looking for does not exist.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
