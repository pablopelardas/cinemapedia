import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_details_moviedb.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDbToEntity(MovieMovieDb movieDb) {
    return Movie(
      adult: movieDb.adult,
      backdropPath:
          movieDb.backdropPath != ''
              ? 'https://image.tmdb.org/t/p/w500${movieDb.backdropPath}'
              : 'https://m.media-amazon.com/images/I/61s8vyZLSzL._AC_UF894,1000_QL80_.jpg',
      genreIds: movieDb.genreIds.map((e) => e.toString()).toList(),
      id: movieDb.id,
      originalLanguage: movieDb.originalLanguage,
      originalTitle: movieDb.originalTitle,
      overview: movieDb.overview,
      popularity: movieDb.popularity,
      posterPath:
          movieDb.posterPath != ''
              ? 'https://image.tmdb.org/t/p/w500${movieDb.posterPath}'
              : 'https://m.media-amazon.com/images/I/61s8vyZLSzL._AC_UF894,1000_QL80_.jpg',
      releaseDate: movieDb.releaseDate,
      title: movieDb.title,
      video: movieDb.video,
      voteAverage: movieDb.voteAverage,
      voteCount: movieDb.voteCount,
    );
  }

  static Movie movieDetailsToEntity(MovieDetailsMovieDb movieDb) {
    return Movie(
      adult: movieDb.adult,
      backdropPath:
          movieDb.backdropPath != ''
              ? 'https://image.tmdb.org/t/p/w500${movieDb.backdropPath}'
              : 'https://m.media-amazon.com/images/I/61s8vyZLSzL._AC_UF894,1000_QL80_.jpg',
      genreIds: movieDb.genres.map((e) => e.name).toList(),
      id: movieDb.id,
      originalLanguage: movieDb.originalLanguage,
      originalTitle: movieDb.originalTitle,
      overview: movieDb.overview,
      popularity: movieDb.popularity,
      posterPath:
          movieDb.posterPath != ''
              ? 'https://image.tmdb.org/t/p/w500${movieDb.posterPath}'
              : 'https://m.media-amazon.com/images/I/61s8vyZLSzL._AC_UF894,1000_QL80_.jpg',
      releaseDate: movieDb.releaseDate,
      title: movieDb.title,
      video: movieDb.video,
      voteAverage: movieDb.voteAverage,
      voteCount: movieDb.voteCount,
    );
  }
}
