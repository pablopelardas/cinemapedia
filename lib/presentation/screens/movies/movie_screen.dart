import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const String name = 'movie-screen';
  final String movieId;
  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();

    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorsProvider.notifier).loadMovie(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];
    return Scaffold(
      body:
          movie == null
              ? const Center(child: CircularProgressIndicator())
              : _MovieView(movie: movie),
    );
  }
}

class _MovieView extends StatelessWidget {
  final Movie movie;
  const _MovieView({required this.movie});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        _CustomSliverAppBar(movie: movie),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => _MovieDetails(movie: movie),
            childCount: 1,
          ),
        ),
      ],
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;
  const _MovieDetails({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  width: size.width * 0.3,
                  height: size.height * 0.3,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),

              SizedBox(
                width: (size.width - 40) * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title, style: textStyles.titleLarge),
                    const SizedBox(height: 10),
                    Text(movie.overview, style: textStyles.bodyMedium),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),

        //Generos
        Padding(
          padding: EdgeInsets.all(8),
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              ...movie.genreIds.map(
                (genre) => Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Chip(
                    label: Text(genre),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    backgroundColor: Colors.white,
                    labelStyle: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),

        //TODO: Actores
        _ActorsByMovie(movieId: movie.id),
        const SizedBox(height: 100),
      ],
    );
  }
}

class _ActorsByMovie extends ConsumerWidget {
  final int movieId;
  const _ActorsByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actors = ref.watch(actorsProvider)['$movieId'];
    if (actors == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return SizedBox(
      height: 300,
      child: ListView.builder(
        itemCount: actors.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final actor = actors[index];
          return Container(
            padding: const EdgeInsets.all(8.0),
            width: 135,
            child: Column(
              children: [
                FadeInRight(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      actor.profilePath,
                      width: 135,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(actor.name),
                const SizedBox(height: 5),
                Text(
                  actor.character ?? '',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

final isFavoriteProvider = FutureProvider.family<bool, int>((ref, movieId) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return localStorageRepository.isMovieFavorite(movieId);
});

class _CustomSliverAppBar extends ConsumerWidget {
  const _CustomSliverAppBar({required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavoriteFuture = ref.watch(isFavoriteProvider(movie.id));
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          icon: isFavoriteFuture.when(
            data:
                (isFavorite) => Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.white,
                ),
            error: (error, stackTrace) => const Icon(Icons.error),
            loading: () => const CircularProgressIndicator(),
          ),
          onPressed: () async {
            await ref
                .watch(localStorageRepositoryProvider)
                .toggleFavorite(movie);
            ref.invalidate(isFavoriteProvider(movie.id));
          },
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        title: Text(
          movie.title,
          style: const TextStyle(fontSize: 20, color: Colors.white),
          textAlign: TextAlign.start,
        ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return FadeIn(child: child);
                  }
                  return const SizedBox();
                },
              ),
            ),
            _CustomGradient(
              colors: [Colors.transparent, Colors.black87],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.7, 1],
            ),

            _CustomGradient(
              colors: [Colors.black54, Colors.transparent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 0.2],
            ),

            _CustomGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.black54, Colors.transparent],
              stops: [0.0, 0.2],
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomGradient extends StatelessWidget {
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<Color> colors;
  final List<double> stops;
  const _CustomGradient({
    this.begin = Alignment.topLeft,
    this.end = Alignment.bottomRight,
    this.colors = const [Colors.black54, Colors.transparent],
    this.stops = const [0.0, 0.3],
  }) : assert(
         colors.length == stops.length,
         'Colors and stops must have the same length.',
       );

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: begin,
            end: end,
            stops: stops,
          ),
        ),
      ),
    );
  }
}
