import 'package:flutter/services.dart';

import 'game.dart';

/// DAO for accessing the game database.
class GameDAO {

  final GameList gameList;
  final Map<String,GameShell> shellIdToGameShell;

  GameDAO._(this.gameList) : shellIdToGameShell = _buildShellIdToGameShellMap(gameList);

  /// Parses the GameDAO from the game.json file (hence async)
  static Future<GameDAO> createAsync() async {
    return rootBundle.loadString('assets/game.json')
        .then((value) => GameDAO._(GameListMapper.fromJson(value)));
  }

  static Map<String,GameShell> _buildShellIdToGameShellMap(GameList gameList) {
    final gameShells = gameList.games
        .expand((game) => game.shells.map((shell) => GameShell(game, shell)));
    return Map.unmodifiable({ for (var v in gameShells) v.shell.id : v });
  }
}

class GameShell {
  final Game game;
  final Shell shell;

  const GameShell(this.game, this.shell);
}