import 'package:flutter/material.dart';

class ChartStore extends ChangeNotifier {
  List<Map<String, int>> chart = [
    {"food": 0},
    {"travel": 0},
    {"leisure": 0},
    {"work": 0},
    {"other": 0},
  ];

  void addChart(String key) {
    for (var item in chart) {
      if (item.containsKey(key)) {
        item[key] = item[key]! + 1;
        break;
      }
    }
    notifyListeners();
  }

  void removeChart(String key) {
    for (var item in chart) {
      if (item.containsKey(key)) {
        item[key] = item[key]! - 1;
        break;
      }
    }
    notifyListeners();
  }
}
