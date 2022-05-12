import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../secrets.dart';

final _appwriteProvider = Provider<Client>((ref) {
  return Client(
    endPoint: Secrets.appwriteURL + "/v1",
    selfSigned: true,
  )..setProject(Secrets.appwriteProject);
});

final accountsProvider = Provider<Account>((ref) {
  return Account(ref.read(_appwriteProvider));
});

final dbProvider = Provider<Database>((ref) {
  return Database(ref.read(_appwriteProvider));
});
