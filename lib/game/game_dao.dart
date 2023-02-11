import 'package:flutter/services.dart';

import 'game.dart';

/// DAO for accessing the game database.
class GameDAO {

  final GameList gameList;

  GameDAO._(this.gameList);

  /// Parses the GameDAO from the game.json file (hence async)
  static Future<GameDAO> createAsync() async {
    return rootBundle.loadString('assets/game.json')
        .then((value) => GameDAO._(GameListMapper.fromJson(value)));
  }
}