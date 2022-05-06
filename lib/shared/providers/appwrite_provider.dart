import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _appwriteProvider = Provider<Client>((ref) {
  return Client(
    endPoint: const String.fromEnvironment("APPWRITE_URL") + "/v1",
    selfSigned: true,
  )..setProject(const String.fromEnvironment("PROJECT_ID"));
});

final accountsProvider = Provider<Account>((ref) {
  return Account(ref.read(_appwriteProvider));
});
