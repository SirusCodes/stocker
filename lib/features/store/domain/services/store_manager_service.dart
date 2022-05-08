import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/providers/appwrite_provider.dart';
import '../models/worker_model.dart';

final storeManagerService = Provider<StoreManagerService>((ref) {
  return StoreManagerService(ref.read);
});

class StoreManagerService {
  StoreManagerService(Reader read) : _teams = read(teamsProvider);
  final Teams _teams;

  Future<String?> getStore() async {
    final teamList = await _teams.list();

    if (teamList.total <= 0) return null;

    return teamList.teams.first.$id;
  }

  Future<String> createStore(String name) async {
    final team = await _teams.create(teamId: "unique()", name: name);

    return team.$id;
  }

  Future<WorkerModel?> addWorker(String email) async {
    try {
      final _teamId = await getStore();
      final worker = await _teams.createMembership(
        teamId: _teamId!,
        email: email,
        roles: ["worker"],
        url: "",
      );

      return WorkerModel(
        name: worker.name,
        email: worker.email,
        id: worker.$id,
      );
    } catch (_) {
      return null;
    }
  }

  Future<List<WorkerModel>> getWorkers() async {
    final _teamId = await getStore();
    final _members = await _teams.getMemberships(teamId: _teamId!);

    return _members.memberships
        .map((e) => WorkerModel(name: e.name, email: e.email, id: e.$id))
        .toList();
  }

  Future<bool> removeWorker(String workerId) async {
    final _teamId = await getStore();
    try {
      await _teams.deleteMembership(teamId: _teamId!, membershipId: workerId);
      return true;
    } on AppwriteException catch (_) {
      return false;
    }
  }
}
