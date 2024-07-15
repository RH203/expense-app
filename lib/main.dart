import 'package:expense_app/src/app.dart';
import 'package:expense_app/src/store/chart_store.dart';
import 'package:expense_app/src/store/expense_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ExpenseStore()),
        ChangeNotifierProvider(create: (_) => ChartStore())
      ],
      child: const App(),
    ),
  );
}
