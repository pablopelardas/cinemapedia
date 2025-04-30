import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

class MoviesSlideshow extends StatelessWidget {
  final List<Movie> movies;
  const MoviesSlideshow({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SizedBox(
      height: 275,
      width: double.infinity,
      child: Swiper(
        itemCount: movies.length,
        itemBuilder:
            (BuildContext context, int index) => _Slide(movie: movies[index]),
        viewportFraction: 0.8,
        scale: 0.9,
        autoplay: true,
        pagination: SwiperPagination(
          margin: EdgeInsets.only(top: 0),
          alignment: Alignment.bottomCenter,
          builder: SwiperPagination(
            builder: DotSwiperPaginationBuilder(
              activeColor: colors.primary,
              color: colors.secondary,
            ),
          ),
        ),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 60),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 10,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            movie.backdropPath,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return FadeIn(child: child);
              return const DecoratedBox(
                decoration: BoxDecoration(color: Colors.black12),
              );
            },
          ),
        ),
      ),
    );
  }
}
