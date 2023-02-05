import 'package:flutter/material.dart';
import 'package:my_virtual_pet_collection/game/game_dao.dart';
import '../main.dart';

class AddTrackedShellPage extends StatelessWidget {
  final GameDAO gameDAO;

  AddTrackedShellPage({super.key}) :
    gameDAO = getIt.get<GameDAO>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Game'),
      ),
      body: Center(
        child: ListView(
          children: gameDAO.gameList.games.map((e) => Text(e.names.name())).toList()
        )
      ),
    );
  }
}