import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_masonry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
  bool isLastPage = false;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    loadNextPage();
  }

  void loadNextPage() {
    if (isLastPage || isLoading) return;
    isLoading = true;
    ref.read(favoriteMoviesProvider.notifier).loadNextPage().then((movies) {
      isLoading = false;
      if (movies.isEmpty) {
        isLastPage = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMovies = ref.watch(favoriteMoviesProvider).values.toList();
    return Scaffold(
      body: MovieMasonry(
        movies: favoriteMovies,
        loadNextPage: () {
          ref.read(favoriteMoviesProvider.notifier).loadNextPage();
        },
      ),
    );
  }
}
