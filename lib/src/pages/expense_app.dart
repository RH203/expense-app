import 'package:expense_app/src/constant/constant.dart';
import 'package:expense_app/src/models/expense.dart';
import 'package:expense_app/src/store/chart_store.dart';
import 'package:expense_app/src/store/expense_store.dart';
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

  final Map<Category, String> dropDownCategory = {
    Category.food: "food",
    Category.leisure: "leisure",
    Category.other: "other",
    Category.travel: "travel",
    Category.work: "work",
  };

  String getValueByKey(Map<Category, String> category, Category target) {
    for (var entry in category.entries) {
      if (entry.key == target) {
        return entry.value;
      }
    }
    return "";
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
    final chart = context.watch<ChartStore>().chart;
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
                height: 300,
                child: BarChart(
                  randomData(chart),
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
                                onPressed: () {
                                  _removeItem(expense);
                                  Provider.of<ChartStore>(context).removeChart(
                                      getValueByKey(
                                          dropDownCategory, expense.category));
                                },
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
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );

  if (value == 0) {
    return const Text('0', style: style);
  } else if (value == 10) {
    return const Text('2', style: style);
  } else if (value == 20) {
    return const Text('4', style: style);
  } else if (value == 30) {
    return const Text('6', style: style);
  } else if (value == 40) {
    return const Text('8', style: style);
  } else if (value == 50) {
    return const Text('10', style: style);
  } else {
    return const Text('', style: style);
  }
}

Widget getXTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );

  if (value == 0) {
    return const Text('1', style: style);
  } else if (value == 10) {
    return const Text('2', style: style);
  } else if (value == 20) {
    return const Text('3', style: style);
  } else if (value == 30) {
    return const Text('4', style: style);
  } else if (value == 40) {
    return const Text('5', style: style);
  } else {
    return const Text('', style: style);
  }
}

BarChartData randomData(List<Map<String, int>> chart) {
  return BarChartData(
    maxY: 100.0,
    barTouchData: BarTouchData(
      enabled: false,
    ),
    titlesData: const FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(),
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
    barGroups: List.generate(5, (index) {
      String key = index == 0
          ? "food"
          : index == 1
              ? "travel"
              : index == 2
                  ? "leisure"
                  : index == 3
                      ? "work"
                      : "other";
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: chart[index][key]!.toDouble(),
            color: Colors.blue,
            borderRadius: BorderRadius.zero,
            width: 30,
          ),
        ],
      );
    }),
    gridData: const FlGridData(show: false),
  );
}
