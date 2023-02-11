import 'package:flutter/material.dart';
import 'package:my_virtual_pet_collection/game/game_dao.dart';
import 'package:my_virtual_pet_collection/user/user_dao.dart';
import 'package:provider/provider.dart';
import 'add_tracked_shell_page.dart';
import 'package:get_it/get_it.dart';

import 'owned_shell_details.dart';

final GetIt getIt = GetIt.instance;

void main() {
  // needed because of the async logic that happens in _init
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

Future _init() async {
  getIt.registerSingleton(await GameDAO.createAsync());
  getIt.registerSingleton(await UserDAO.createAsync());
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text("My Virtual Pet Collection",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                )),
            CircularProgressIndicator()
          ],
        )
    );
  }
}

class MyApp extends StatelessWidget {
  final Future _initFuture = _init();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Virtual Pet Collection',
      home: FutureBuilder(
          future: _initFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return HomePage();
            } else {
              return SplashScreen();
            }
          })
    );
  }
}

class HomePage extends StatelessWidget {
  final UserDAO userDAO;
  HomePage({super.key}) : userDAO = getIt.get<UserDAO>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Virtual Pet Collection'),
      ),
      body: ChangeNotifierProvider(
        create: (context) => userDAO,
        child: Center(
          child: Consumer<UserDAO>(
            builder: (context, userDAO, child) {
              return ListView.builder(
                itemCount: userDAO.ownedShells.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Card(
                      child: ListTile(
                        title: Text(userDAO.ownedShells[index].nickname),
                      ),
                    ),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OwnedShellDetailsScreen(userDAO.ownedShells[index]))),
                  );
                }
              );
            }
          )
        )
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'addTrackedShell',
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddTrackedShellPage()
              ));
        },
      ),
    );
  }

}