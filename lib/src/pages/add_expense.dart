import 'package:expense_app/src/constant/constant.dart';
import 'package:expense_app/src/models/expense.dart';
import 'package:expense_app/src/store/chart_store.dart';
import 'package:expense_app/src/store/expense_store.dart';
import 'package:expense_app/src/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  final Map<Category, String> dropDownCategory = {
    Category.food: "food",
    Category.leisure: "leisure",
    Category.other: "other",
    Category.travel: "travel",
    Category.work: "work",
  };

  String dropdownValue = "food";

  DateTime? selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate!,
      firstDate: DateTime(1200),
      lastDate: DateTime(3000),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        print(selectedDate);
      });
    }
  }

  Category? getKeyByValue(Map<Category, String> category, String target) {
    for (var entry in category.entries) {
      if (entry.value == target) {
        return entry.key;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    int day = selectedDate?.day ?? 0;
    int month = selectedDate?.month ?? 0;
    int year = selectedDate?.year ?? 0;

    final List<Map<String, dynamic>> field = [
      {
        "labelText": "Title",
        "hintText": "Enter your title",
        "controller": titleController,
      },
      {
        "labelText": "Amount",
        "hintText": "Enter your amount",
        "controller": amountController,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Expense"),
        elevation: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: field.map((data) {
                return CustomTextField(
                  labelText: data["labelText"],
                  hintText: data["hintText"],
                  controller: data["controller"],
                );
              }).toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DropdownButton<String>(
                  value: dropdownValue,
                  onChanged: (String? value) {
                    if (value != null) {
                      setState(() {
                        dropdownValue = value;
                      });
                    }
                  },
                  items: dropDownCategory.entries.map((entry) {
                    return DropdownMenuItem<String>(
                      value: entry.value,
                      child: Text(entry.value),
                    );
                  }).toList(),
                ),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: Text(
                    "$day-$month-$year",
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  if (titleController.text.isNotEmpty &&
                      amountController.text.isNotEmpty) {
                    Expense value = Expense(
                      title: titleController.text,
                      amount: double.parse(amountController.text),
                      date: selectedDate ?? DateTime.now(),
                      category:
                          getKeyByValue(dropDownCategory, dropdownValue) ??
                              Category.food,
                    );
                    context.read<ExpenseStore>().addValue(value);

                    context.read<ChartStore>().addChart(dropdownValue);

                    titleController.clear();
                    amountController.clear();

                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Berhasil'),
                        content: const Text('Data berhasil dimasukan'),
                        actions: [
                          TextButton(
                            onPressed: () =>
                                Navigator.popAndPushNamed(context, homeRoute),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Validation Error'),
                        content:
                            const Text('Title and amount must not be empty.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: const Text(
                  "Add",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
