import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/now_playing_response.dart';

class MoviedbDatasource implements MoviesDatasource {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      headers: {
        'Content-Type': 'application/json;charset=utf-8',
        'Authorization': 'Bearer ${Environment.movieDbKey}',
      },
      queryParameters: {'language': 'es-MX'},
    ),
  );

  @override
  Future<List<Movie>> getNowPlayingMovies({int page = 1}) async {
    try {
      final response = await dio.get(
        '/movie/now_playing',
        queryParameters: {'page': page},
      );
      final List<Movie> movies =
          NowPlayingResponse.fromJson(
            response.data,
          ).results.map((movie) => MovieMapper.movieDbToEntity(movie)).toList();
      return movies;
    } catch (e) {
      // Handle error
      debugPrint('Error fetching now playing movies: $e');
      return [];
    }
  }
}
