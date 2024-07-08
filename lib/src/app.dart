import 'package:expense_app/src/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:expense_app/src/router/router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Expense app",
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routers.generateRoute,
      initialRoute: homeRoute,
    );
  }
}
