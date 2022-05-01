import 'package:flutter/material.dart';

import '../features/category/domain/domain.dart';
import '../features/category/presentation/save_category_screen.dart';
import '../features/home/presentation/home_base.dart';
import '../features/transaction/presentation/transaction_history_screen.dart';
import '../features/users/presentation/profile_screen.dart';
import '../features/users/presentation/update_password_screen.dart';

class RouteGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => const HomeBase());
      case TransactionHistoryScreen.path:
        return MaterialPageRoute(
          builder: (_) => const TransactionHistoryScreen(),
        );
      case ProfileScreen.path:
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
        );
      case UpdatePasswordScreen.path:
        return MaterialPageRoute(
          builder: (_) => const UpdatePasswordScreen(),
        );
      case SaveCategoryScreen.path:
        final category = settings.arguments as CategoryModel?;
        return MaterialPageRoute(
          builder: (_) => SaveCategoryScreen(category: category),
        );
      default:
        return MaterialPageRoute(builder: (context) => const HomeBase());
    }
  }
}
