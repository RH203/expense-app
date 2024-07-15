import 'dart:math';

import 'package:expense_app/src/constant/constant.dart';
import 'package:expense_app/src/store/expense_store.dart';
import 'package:expense_app/src/models/expense.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseApp extends StatefulWidget {
  const ExpenseApp({super.key});

  @override
  State<ExpenseApp> createState() => _ExpenseAppState();
}

class _ExpenseAppState extends State<ExpenseApp> {
  Icon iconCategory(Category value) {
    switch (value) {
      case Category.food:
        return const Icon(Icons.fastfood_outlined);
      case Category.leisure:
        return const Icon(Icons.celebration);
      case Category.other:
        return const Icon(Icons.heat_pump);
      case Category.travel:
        return const Icon(Icons.explore);
      case Category.work:
        return const Icon(Icons.work);
      default:
        return const Icon(Icons.error);
    }
  }

  void _removeItem(Expense value) {
    context.read<ExpenseStore>().removeValue(value);
    Navigator.pop(context, true);
    final snackBar = SnackBar(
      content: Text("${value.title} Deleted"),
      action: SnackBarAction(
        label: "OK",
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense app"),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, addRoute),
            icon: const Icon(Icons.add),
          ),
        ],
        elevation: 10,
      ),
      body: Container(
        margin: const EdgeInsets.all(8),
        child: CustomScrollView(
          slivers: [
            // Chart
            //! slivers only accept slivers widget
            SliverToBoxAdapter(
              child: SizedBox(
                height: 250,
                child: BarChart(
                  randomData(),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: context.watch<ExpenseStore>().list.length,
                (context, index) {
                  final expense = context.watch<ExpenseStore>().list[index];
                  return Dismissible(
                    confirmDismiss: (direction) async {
                      return await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Confirm"),
                            content: const Text(
                                "Are you sure you wish to delete this item?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, false);
                                },
                                child: const Text("No"),
                              ),
                              TextButton(
                                onPressed: () => _removeItem(expense),
                                child: const Text("Yes"),
                              )
                            ],
                          );
                        },
                      );
                    },
                    direction: DismissDirection.endToStart,
                    key: Key(expense.id),
                    onDismissed: (direction) {
                      () => _removeItem(expense);
                    },
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                    child: ListTile(
                      key: Key(expense.id),
                      title: Row(
                        children: [
                          Text(expense.title),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            context
                                .watch<ExpenseStore>()
                                .list[index]
                                .amount
                                .toString(),
                          )
                        ],
                      ),
                      subtitle: Text(
                        "${expense.date.day.toString()}-${expense.date.month.toString()}-${expense.date.year.toString()}",
                      ),
                      trailing: iconCategory(
                        expense.category,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

BarChartGroupData makeGroupData(int x, double y) {
  return BarChartGroupData(
    x: x,
    barRods: [
      BarChartRodData(
        toY: y,
        color: Colors.blue,
        borderRadius: BorderRadius.zero,
        width: 30,
      ),
    ],
  );
}

Widget getYTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );

  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 8,
    child: Text(value.toInt().toString(), style: style),
  );
}

BarChartData randomData() {
  return BarChartData(
    maxY: 300.0,
    barTouchData: BarTouchData(
      enabled: false,
    ),
    titlesData: const FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: getYTitles,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: getYTitles,
        ),
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: false,
        ),
      ),
      rightTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: false,
        ),
      ),
    ),
    borderData: FlBorderData(
      show: false,
    ),
    barGroups: List.generate(
      4,
      (i) => makeGroupData(i, Random().nextInt(100).toDouble() + 10),
    ),
    gridData: const FlGridData(show: false),
  );
}
