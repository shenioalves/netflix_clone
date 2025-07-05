import 'package:flutter/material.dart';
import 'package:netflix_clone/app/model/movie_model.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  const MovieCard({required this.movie, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(movie.posterUrl),
        Text(movie.title, style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
