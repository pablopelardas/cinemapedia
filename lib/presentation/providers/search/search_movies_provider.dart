import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchMoviesProvider =
    StateNotifierProvider<SearchMoviesNotifier, List<Movie>>((ref) {
      final movieRepository = ref.read(movieRepositoryProvider);
      return SearchMoviesNotifier(
        searchMovies: movieRepository.searchMovies,
        ref: ref,
      );
    });
typedef SearchMovieCallback = Future<List<Movie>> Function(String query);

class SearchMoviesNotifier extends StateNotifier<List<Movie>> {
  SearchMoviesNotifier({required this.searchMovies, required this.ref})
    : super([]);

  final SearchMovieCallback searchMovies;
  final Ref ref;

  Future<List<Movie>> searchMoviesByQuery(String query) async {
    // Simulate a network call
    ref.read(searchQueryProvider.notifier).state = query;
    if (query.isEmpty) {
      state = [];
      return [];
    }
    // Update the search query in the provider
    final List<Movie> movies = await searchMovies(query);
    state = movies;
    return movies;
  }
}
