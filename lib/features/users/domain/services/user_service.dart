import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/providers/appwrite_provider.dart';
import '../models/user_model.dart';

final userService = Provider<UserService>((ref) {
  final account = ref.read(accountsProvider);
  return UserService(account);
});

class UserService {
  UserService(Account account) : _account = account;
  final Account _account;

  Future<UserModel> updatePassword({
    required String newPassword,
    required String oldPassword,
  }) async {
    final user = await _account.updatePassword(
      password: newPassword,
      oldPassword: oldPassword,
    );
    return UserModel(user.name, user.email);
  }

  Future<UserModel> getUserInfo() async {
    final user = await _account.get();
    return UserModel(user.name, user.email);
  }
}
