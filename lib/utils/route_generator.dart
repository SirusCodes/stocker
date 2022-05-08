import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../enums/enums.dart';
import '../features/authentication/presentation/auth_screen.dart';
import '../features/authentication/providers/auth_provider.dart';
import '../features/category/domain/domain.dart';
import '../features/category/presentation/save_category_screen.dart';
import '../features/home/presentation/home_base.dart';
import '../features/product/presentation/product_base_screen.dart';
import '../features/product/presentation/save_product_screen.dart';
import '../features/share_store/presentation/create_join_store.dart';
import '../features/share_store/presentation/scan_code_screen.dart';
import '../features/share_store/presentation/store_manager_screen.dart';
import '../features/transaction/presentation/add_transaction_screen.dart';
import '../features/transaction/presentation/transaction_history_screen.dart';
import '../features/users/presentation/profile_screen.dart';
import '../features/users/presentation/update_password_screen.dart';

class RouteGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (_) => _buildAuthLogin(),
        );
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
      case ProductBaseScreen.path:
        final category = settings.arguments as CategoryModel;
        return MaterialPageRoute(
          builder: (_) => ProductBaseScreen(category: category),
        );
      case SaveProductScreen.path:
        final args = settings.arguments as SaveProductScreenArguments;
        return MaterialPageRoute(
          builder: (_) => SaveProductScreen(arguments: args),
        );
      case AddTransactionScreen.path:
        return MaterialPageRoute(
          builder: (_) => const AddTransactionScreen(),
        );
      case CreateJoinStore.path:
        return MaterialPageRoute(
          builder: (_) => const CreateJoinStore(),
        );
      case StoreManagerScreen.path:
        return MaterialPageRoute(
          builder: (_) => const StoreManagerScreen(),
        );
      case ScanCodeScreen.path:
        return MaterialPageRoute(
          builder: (_) => const ScanCodeScreen(),
        );
      default:
        return MaterialPageRoute(builder: (context) => const HomeBase());
    }
  }

  static Widget _buildAuthLogin() {
    return Consumer(
      builder: (context, ref, child) {
        final _authState = ref.watch(authProvider);
        if (_authState == AuthState.authenticated) {
          return const HomeBase();
        } else if (_authState == AuthState.unauthenticated) {
          return const AuthScreen();
        }

        return const Material(
          child: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
