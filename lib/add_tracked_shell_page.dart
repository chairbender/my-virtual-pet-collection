import 'package:flutter/material.dart';
import 'package:my_virtual_pet_collection/game/game_dao.dart';
import '../main.dart';
import 'game/game.dart';

// TODO: sort list alphabetically
// TODO: make it searchable (prefix)
class AddTrackedShellPage extends StatelessWidget {
  final List<Game> games;

  AddTrackedShellPage({super.key}) :
        games = _sortGames(getIt.get<GameDAO>());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Game'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: games.length,
          prototypeItem: ListTile(
            title: Text(games.first.names.name())
          ),
          itemBuilder: (context, index) {
            return Card(
                child: ListTile(
                  title: Text(games[index].names.name()),
                )
            );
          },
        )
      ),
    );
  }

  static List<Game> _sortGames(GameDAO gameDAO) {
    final result = List<Game>.from(gameDAO.gameList.games);
    result.sort((a, b) => a.names.name().compareTo(b.names.name()));
    return result;
  }
}