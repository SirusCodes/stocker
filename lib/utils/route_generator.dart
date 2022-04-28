import 'package:flutter/material.dart';
import 'package:stocker_appwrite/features/home/presentation/home_base.dart';
import 'package:stocker_appwrite/features/transaction/presentation/transaction_history_screen.dart';

class RouteGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => const HomeBase());
      case TransactionHistoryScreen.path:
        return MaterialPageRoute(
          builder: (_) => const TransactionHistoryScreen(),
        );
      default:
        return MaterialPageRoute(builder: (context) => const HomeBase());
    }
  }
}
