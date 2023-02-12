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
        gameShell =
            getIt.get<GameDAO>().shellIdToGameShell[ownedShell.shellId]!;

  @override
  Widget build(BuildContext context) {
    // TODO: details of shell, edit and delete (with confirm popup), clickable list of obtained pets
    return Scaffold(
      appBar: AppBar(title: Text(ownedShell.nickname)),
      body: Center(
        child: ListView(
          children: [
            Card(
              child: Column(
                children: [
                  Text("Game: ${gameShell.game.names.name()}"),
                  Text("Shell: ${gameShell.shell.names.name()}"),
                  CheckboxListTile(
                      title: const Text("Currently Owned?"),
                      value: ownedShell.currentlyOwned,
                      enabled: false,
                      onChanged: (_) {}),
                  ElevatedButton(onPressed: () {}, child: const Text('Edit')),
                  ElevatedButton(
                      child: const Text('Delete'),
                      onPressed: () => showDialog<bool>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: const Text('Confirm Deletion'),
                                content: const Text('Delete this shell and all obtained pets?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                    child: const Text('OK'),
                                  ),
                                ],
                              )).then((confirmed) async {
                                if (!confirmed!) return;
                                await userDAO.deleteOwnedShell(ownedShell.id);
                                // TODO: I think this should be okay despite the warning?
                                if (!context.mounted) return;
                                Navigator.of(context)
                                    .popUntil((route) => route.isFirst);
                              })
                  ),
                ],
              ),
            ),
            Card(
              child: Column(
                children: gameShell.game.pets.map((pet) {
                  // TODO: sort alphabetically
                  // TODO: enable obtaining (click, probably goes to pet detail screen)
                  return CheckboxListTile(
                      title: Text(pet.names.name()),
                      // TODO: check ownership status
                      value: false,
                      onChanged: (_) {});
                }).toList(growable: false),
              ),
            )
          ],
        ),
      ),
    );
  }
}
