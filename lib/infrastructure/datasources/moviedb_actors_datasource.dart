import 'package:dio/dio.dart';
import 'package:cinemapedia/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';
import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/config/constants/environment.dart';

class MoviedbActorsDatasource implements ActorsDatasource {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      headers: {
        'Content-Type': 'application/json;charset=utf-8',
        'Authorization': 'Bearer ${Environment.movieDbKey}',
      },
    ),
  );

  List<Actor> _jsonToActors(Map<String, dynamic> json) {
    final List<Actor> actors =
        CreditsResponse.fromJson(
          json,
        ).cast.map((cast) => ActorMapper.castToEntity(cast)).toList();
    return actors;
  }

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {
    final url = '/movie/$movieId/credits';
    return dio
        .get(url)
        .then((response) => _jsonToActors(response.data))
        .catchError((error) {
          throw Exception('Error fetching actors: $error');
        });
  }
}
