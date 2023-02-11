
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:my_virtual_pet_collection/user/user.dart';

/// DAO for accessing user's data
class UserDAO extends ChangeNotifier {
  final Isar isar;
  /// maintains list of all owned shells
  List<OwnedShell> ownedShells;

  UserDAO(this.isar, this.ownedShells);

  createOwnedShell(OwnedShell ownedShell) async {
    await isar.writeTxn(() async {
      await isar.ownedShells.put(ownedShell);
    });
    ownedShells = await _fetchOwnedShells(isar);
    notifyListeners();
  }

  static Future<List<OwnedShell>> _fetchOwnedShells(Isar isar) async {
    return isar.txn(() async { return List.unmodifiable(await isar.ownedShells.where().findAll()); });
  }

  static Future<UserDAO> createAsync() async {
    return Isar.open([OwnedShellSchema,ObtainedPetSchema])
        .then((value) async => UserDAO(value, await _fetchOwnedShells(value)));
  }
}