import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/infrastructure/datasources/moviedb_actors_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/actors_repository_impl.dart';

final actorsRepositoryProvider = Provider((ref) {
  return ActorsRepositoryImpl(MoviedbActorsDatasource());
});
