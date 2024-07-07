import 'package:flutter/material.dart';

class ExpenseApp extends StatefulWidget {
  const ExpenseApp({super.key});

  @override
  State<ExpenseApp> createState() => _ExpenseAppState();
}

class _ExpenseAppState extends State<ExpenseApp> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Hello world"),
    );
  }
}
