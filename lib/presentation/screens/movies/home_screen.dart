import 'package:cinemapedia/domain/repositories/movies_repository.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  static const String name = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MoviesRepository moviesRepository = ref.watch(
      movieRepositoryProvider,
    );
    return Scaffold(
      appBar: AppBar(title: const Text('Cinemapedia'), centerTitle: true),
      body: Center(child: Text('env: ')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          moviesRepository.getNowPlayingMovies(page: 1).then((value) {
            print(value);
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
