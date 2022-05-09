import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/models/user_model.dart';
import '../domain/services/user_service.dart';

final userProvider =
    StateNotifierProvider<UserProvider, AsyncValue<UserModel>>((ref) {
  final service = ref.read(userService);
  return UserProvider(service);
});

class UserProvider extends StateNotifier<AsyncValue<UserModel>> {
  UserProvider(UserService userService)
      : _service = userService,
        super(const AsyncLoading()) {
    _getUserInfo();
  }

  final UserService _service;

  Future<void> _getUserInfo() async {
    state = AsyncData(await _service.getUserInfo());
  }
}
