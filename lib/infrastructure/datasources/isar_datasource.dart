import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatasource implements LocalStorageDatasource {
  late Future<Isar> db;
  IsarDatasource() {
    db = openIsar();
  }
  Future<Isar> openIsar() async {
    if (Isar.instanceNames.isNotEmpty) {
      return Isar.getInstance()!;
    }
    final dir = await getApplicationDocumentsDirectory();
    return await Isar.open([MovieSchema], inspector: true, directory: dir.path);
  }

  @override
  Future<bool> isMovieFavorite(int movieId) {
    return db.then((isar) async {
      final movie = await isar.movies.filter().idEqualTo(movieId).findFirst();
      return movie != null;
    });
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, int offset = 0}) {
    return db.then((isar) async {
      final movies =
          await isar.movies.where().offset(offset).limit(limit).findAll();
      return movies;
    });
  }

  @override
  Future<void> toggleFavorite(Movie movie) {
    return db.then((isar) async {
      final favoriteMovie =
          await isar.movies.filter().idEqualTo(movie.id).findFirst();
      if (favoriteMovie != null) {
        await isar.writeTxn(() async {
          await isar.movies.delete(favoriteMovie.isarId!);
        });
      } else {
        await isar.writeTxn(() async {
          await isar.movies.put(movie);
        });
      }
    });
  }
}
