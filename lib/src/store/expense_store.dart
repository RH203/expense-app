import 'package:expense_app/src/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseStore with ChangeNotifier {
  final List<Expense> _list = [];

  void removeValue(int index) => _list.removeAt(index);
  void addValue(Expense value) => _list.add(value);

  List<Expense> get list => _list;
}
