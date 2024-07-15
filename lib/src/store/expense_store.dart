import 'package:expense_app/src/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseStore with ChangeNotifier {
  final List<Expense> _list = [];

  void removeValue(Expense value) {
    _list.remove(value);
    notifyListeners();
  }

  void addValue(Expense value) {
    _list.add(value);
    notifyListeners();
  }

  List<Expense> get list => _list;
}
