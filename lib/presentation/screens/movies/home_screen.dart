import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';

class HomeScreen extends ConsumerWidget {
  static const String name = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: _HomeView(),
      bottomNavigationBar: const CustomButtomNavigationBar(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final movies = ref.watch(moviesSlideshowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbar(),
            titlePadding: EdgeInsets.all(0),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Column(
              children: [
                MoviesSlideshow(movies: movies),
                MoviesHorizontalListView(
                  movies: nowPlayingMovies,
                  title: 'Now Playing',
                  subtitle: 'Monday 20',
                  loadNextPage:
                      ref
                          .read(nowPlayingMoviesProvider.notifier)
                          .loadNextPage, // Load more movies when reaching the end
                ),

                MoviesHorizontalListView(
                  movies: upcomingMovies,
                  title: 'Upcoming',
                  subtitle: 'This month',
                  loadNextPage:
                      ref
                          .read(upcomingMoviesProvider.notifier)
                          .loadNextPage, // Load more movies when reaching the end
                ),
                MoviesHorizontalListView(
                  movies: popularMovies,
                  title: 'Most popular',
                  loadNextPage:
                      ref
                          .read(popularMoviesProvider.notifier)
                          .loadNextPage, // Load more movies when reaching the end
                ),
                MoviesHorizontalListView(
                  movies: topRatedMovies,
                  title: 'Top rated',
                  subtitle: 'Critically acclaimed',
                  loadNextPage:
                      ref
                          .read(topRatedMoviesProvider.notifier)
                          .loadNextPage, // Load more movies when reaching the end
                ),
                SizedBox(height: 50),
              ],
            );
          }, childCount: 1),
        ),
      ],
    );
  }
}
