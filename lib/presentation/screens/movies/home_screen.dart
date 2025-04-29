import 'package:cinemapedia/infrastructure/datasources/moviedb_datasource.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String name = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cinemapedia'), centerTitle: true),
      body: Center(child: Text('env: ')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          MoviedbDatasource()
              .getNowPlayingMovies(page: 1)
              .then((movies) => print(movies.length));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
