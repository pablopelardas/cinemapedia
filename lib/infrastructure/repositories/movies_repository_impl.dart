import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final MoviesDatasource datasource;
  MoviesRepositoryImpl(this.datasource);
  @override
  Future<List<Movie>> getNowPlayingMovies({int page = 1}) {
    return datasource.getNowPlayingMovies(page: page);
  }

  @override
  Future<List<Movie>> getPopularMovies({int page = 1}) {
    return datasource.getPopularMovies(page: page);
  }

  @override
  Future<List<Movie>> getTopRatedMovies({int page = 1}) {
    return datasource.getTopRatedMovies(page: page);
  }

  @override
  Future<List<Movie>> getUpcomingMovies({int page = 1}) {
    return datasource.getUpcomingMovies(page: page);
  }
}
