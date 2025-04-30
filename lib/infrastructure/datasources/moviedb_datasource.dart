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

  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final List<Movie> movies =
        NowPlayingResponse.fromJson(
          json,
        ).results.map((movie) => MovieMapper.movieDbToEntity(movie)).toList();
    return movies;
  }

  @override
  Future<List<Movie>> getNowPlayingMovies({int page = 1}) async {
    try {
      final response = await dio.get(
        '/movie/now_playing',
        queryParameters: {'page': page},
      );
      return _jsonToMovies(response.data);
    } catch (e) {
      // Handle error
      debugPrint('Error fetching now playing movies: $e');
      return [];
    }
  }

  @override
  Future<List<Movie>> getPopularMovies({int page = 1}) async {
    try {
      final response = await dio.get(
        '/movie/popular',
        queryParameters: {'page': page},
      );
      return _jsonToMovies(response.data);
    } catch (e) {
      // Handle error
      debugPrint('Error fetching popular movies: $e');
      return [];
    }
  }

  @override
  Future<List<Movie>> getTopRatedMovies({int page = 1}) async {
    try {
      final response = await dio.get(
        '/movie/top_rated',
        queryParameters: {'page': page},
      );
      return _jsonToMovies(response.data);
    } catch (e) {
      // Handle error
      debugPrint('Error fetching top rated movies: $e');
      return [];
    }
  }

  @override
  Future<List<Movie>> getUpcomingMovies({int page = 1}) async {
    try {
      final response = await dio.get(
        '/movie/upcoming',
        queryParameters: {'page': page},
      );
      return _jsonToMovies(response.data);
    } catch (e) {
      // Handle error
      debugPrint('Error fetching upcoming movies: $e');
      return [];
    }
  }
}
