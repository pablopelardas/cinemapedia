import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/presentation/providers/actors/actors_repository_provider.dart';

final actorsProvider =
    StateNotifierProvider<ActorsMapNotifier, Map<String, List<Actor>>>((ref) {
      final fetchActors = ref.watch(actorsRepositoryProvider).getActorsByMovie;
      return ActorsMapNotifier(fetchActors: fetchActors);
    });

typedef GetActorCallback = Future<List<Actor>> Function(String movieId);

class ActorsMapNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorCallback fetchActors;
  ActorsMapNotifier({required this.fetchActors}) : super({});

  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) return; // Movie already loaded
    final actors = await fetchActors(movieId); // Fetch the movie
    state = {...state, movieId: actors}; // Update the state with the new movie
  }
}
