import 'package:expense_app/src/pages/add_expense.dart';
import 'package:expense_app/src/pages/expense_app.dart';
import 'package:flutter/material.dart';
import 'package:expense_app/src/constant/constant.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const ExpenseApp());
      case addRoute:
        return MaterialPageRoute(builder: (_) => const AddExpense());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
