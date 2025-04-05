import 'package:ems_task/app.dart';
import 'package:ems_task/core/database/hive_helper.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveHelper.init();

  runApp(MyApp());
}
