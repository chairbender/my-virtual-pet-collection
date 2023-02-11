import 'package:flutter/material.dart';
import 'package:my_virtual_pet_collection/game/game_dao.dart';
import 'package:my_virtual_pet_collection/user/user.dart';
import 'package:get_it/get_it.dart';
import 'package:my_virtual_pet_collection/user/user_dao.dart';

final GetIt getIt = GetIt.instance;

class OwnedShellDetailsScreen extends StatelessWidget {
  final OwnedShell ownedShell;
  final GameShell gameShell;
  final UserDAO userDAO;

  // TODO: handle nullity better
  OwnedShellDetailsScreen(this.ownedShell, {super.key})
    : userDAO = getIt.get<UserDAO>(),
      gameShell = getIt.get<GameDAO>().shellIdToGameShell[ownedShell.shellId]!;

  @override
  Widget build(BuildContext context) {
    // TODO: details of shell, edit and delete (with confirm popup), clickable list of obtained pets
    return Scaffold(
      appBar: AppBar(title: Text(ownedShell.nickname)),
      body: Center(
        child: Column(
          children: [
            // TODO: readonly version of edit screen
          ],
        ),
      ),
    );
  }

}