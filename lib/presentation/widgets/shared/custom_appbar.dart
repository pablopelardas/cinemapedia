import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.movie_outlined, color: colors.primary, size: 40),
              const SizedBox(width: 10),
              Text('Cinemapedia', style: titleStyle),
              const Spacer(),
              IconButton(
                onPressed: () {
                  final currentContext = context;
                  showSearch<Movie?>(
                    query: ref.read(searchQueryProvider),
                    context: currentContext,
                    delegate: SearchMovieDelegate(
                      ref
                          .read(searchMoviesProvider.notifier)
                          .searchMoviesByQuery,
                      ref.read(searchMoviesProvider),
                    ),
                  ).then((movie) {
                    if (movie == null) return;
                    if (!currentContext.mounted) return;
                    currentContext.push('/movie/${movie.id}');
                  });
                },
                icon: const Icon(Icons.search, size: 30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
