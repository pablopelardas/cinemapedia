import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String name = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cinemapedia'), centerTitle: true),
      body: const Center(child: Text('Home Screen')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action to perform when the button is pressed
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
