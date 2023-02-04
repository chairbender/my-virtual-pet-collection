import 'package:flutter/material.dart';

class AddTrackedShellPage extends StatelessWidget {
  const AddTrackedShellPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Shell'),
      ),
      body: const Center(
        child: Text('Shell Picker Goes Here'),
      ),
    );
  }
}