import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/providers/appwrite_provider.dart';

final authService = Provider<AuthService>((ref) {
  return AuthService(ref.read);
});

class AuthService {
  AuthService(Reader read) : _account = read(accountsProvider);
  final Account _account;

  Future<User> register({
    required String name,
    required String email,
    required String password,
  }) {
    return _account.create(
      userId: "unique()",
      email: email,
      password: password,
      name: name,
    );
  }

  Future<Session> login({
    required String email,
    required String password,
  }) {
    return _account.createSession(email: email, password: password);
  }

  Future<void> logout() => _account.deleteSession(sessionId: "");

  Future<User> getUser() {
    return _account.get();
  }
}
