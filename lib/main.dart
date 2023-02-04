import 'package:flutter/material.dart';
import 'add_tracked_shell_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'My Virtual Pet Collection',
      home: HomePage()
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
                  builder: (context) => const AddTrackedShellPage()
              ));
        },
      ),
    );
  }

}