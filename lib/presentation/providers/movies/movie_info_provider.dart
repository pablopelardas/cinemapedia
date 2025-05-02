import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';

final movieInfoProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
      final fetchMovie = ref.watch(movieRepositoryProvider).getMovieById;
      return MovieMapNotifier(fetchMovie: fetchMovie);
    });

typedef GetMovieCallback = Future<Movie> Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallback fetchMovie;
  MovieMapNotifier({required this.fetchMovie}) : super({});

  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) return; // Movie already loaded
    final movie = await fetchMovie(movieId); // Fetch the movie
    state = {...state, movieId: movie};
  }
}
