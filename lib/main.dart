import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/table_provider.dart';
import 'screens/table_plan_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TableProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: TablePlanScreen());
  }
}
