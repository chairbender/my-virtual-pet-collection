import 'package:flutter/material.dart';
import 'package:my_virtual_pet_collection/game/game_dao.dart';
import 'add_tracked_shell_page.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void main() {
  // needed because of the async logic that happens in _init
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

Future _init() async {
  getIt.registerSingleton(await GameDAO.createAsync());
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
              return const HomePage();
            } else {
              return SplashScreen();
            }
          })
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Virtual Pet Collection'),
      ),
      body: const Center(
        child: Text("Your Collection Here"),
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