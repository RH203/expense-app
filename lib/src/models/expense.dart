import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Category { food, travel, leisure, work, other }

class Expense {
  Expense({
    required this.title,
    required this.amout,
    required this.date,
    required this.category
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amout;
  final DateTime date;
  final Category category;
}
