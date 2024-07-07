import 'package:expense_app/src/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseApp extends StatefulWidget {
  const ExpenseApp({super.key});

  @override
  State<ExpenseApp> createState() => _ExpenseAppState();
}

class _ExpenseAppState extends State<ExpenseApp> {
  final List<Expense> _list = [
    Expense(
      title: "Flutter course",
      amout: 20.22,
      date: DateTime.now(),
      category: Category.food,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense app"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
        ],
        elevation: 10,
      ),
      body: Container(),
    );
  }
}
