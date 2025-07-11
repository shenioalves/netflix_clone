import 'package:flutter/material.dart';
import 'package:netflix_clone/app/model/movie_model.dart';

class Movies extends ChangeNotifier {
  final List<Movie> _movies = [];

  List<Movie> get movies => _movies;

  void addMovie(Movie movie) {
    _movies.add(movie);
    notifyListeners();
  }

  void removeMovie(String id) {
    _movies.removeWhere((movie) => movie.id == id);
    notifyListeners();
  }
}
