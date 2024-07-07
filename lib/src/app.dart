import 'package:expense_app/src/pages/expense_app.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Expense app",
      debugShowCheckedModeBanner: false,
      home: ExpenseApp(),
    );
  }
}
