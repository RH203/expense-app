import 'package:expense_app/src/constant/constant.dart';
import 'package:expense_app/src/store/expense_store.dart';
import 'package:expense_app/src/models/expense.dart';
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
      body: CustomScrollView(
        slivers: [
          // Chart
          //! slivers only accept slivers widget
          SliverToBoxAdapter(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: context.watch<ExpenseStore>().list.length,
              (context, index) {
                return Dismissible(
                  key: Key(context.watch<ExpenseStore>().list[index].id),
                  onDismissed: (direction) {
                    context.read<ExpenseStore>().removeValue(index);
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
                    key: Key(context.watch<ExpenseStore>().list[index].id),
                    trailing: iconCategory(
                        context.watch<ExpenseStore>().list[index].category),
                    subtitle: Text(
                        "${context.watch<ExpenseStore>().list[index].date.day.toString()}-${context.watch<ExpenseStore>().list[index].date.month.toString()}-${context.watch<ExpenseStore>().list[index].date.year.toString()}"),
                    title:
                        Text(context.watch<ExpenseStore>().list[index].title),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
