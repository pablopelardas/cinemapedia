import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/local_storage_repository.dart';

class LocalStorageRepositoryImpl implements LocalStorageRepository {
  final LocalStorageDatasource localStorageDatasource;
  LocalStorageRepositoryImpl({required this.localStorageDatasource});
  @override
  Future<bool> isMovieFavorite(int movieId) {
    return localStorageDatasource.isMovieFavorite(movieId);
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, int offset = 0}) {
    return localStorageDatasource.loadMovies(limit: limit, offset: offset);
  }

  @override
  Future<void> toggleFavorite(Movie movie) {
    return localStorageDatasource.toggleFavorite(movie);
  }
}
