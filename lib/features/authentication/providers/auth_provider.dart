import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../enums/enums.dart';
import '../domain/auth_service.dart';

final authProvider = StateNotifierProvider<AuthProvider, AuthState>((ref) {
  return AuthProvider(ref.read);
});

class AuthProvider extends StateNotifier<AuthState> {
  AuthProvider(Reader read)
      : _service = read(authService),
        super(AuthState.unknown) {
    _getAuthStatus();
  }

  final AuthService _service;

  Future<void> _getAuthStatus() async {
    try {
      await _service.getUser();
      state = AuthState.authenticated;
    } on AppwriteException catch (_) {
      state = AuthState.unauthenticated;
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    state = AuthState.authenticating;
    try {
      await _service.register(email: email, password: password, name: name);
      await _service.login(email: email, password: password);
      state = AuthState.authenticated;
    } on AppwriteException catch (_) {
      state = AuthState.unauthenticated;
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = AuthState.authenticating;
    try {
      await _service.login(email: email, password: password);
      state = AuthState.authenticated;
    } on AppwriteException catch (_) {
      state = AuthState.unauthenticated;
    }
  }

  Future<void> logout() async {
    await _service.logout();
    state = AuthState.unauthenticated;
  }
}
