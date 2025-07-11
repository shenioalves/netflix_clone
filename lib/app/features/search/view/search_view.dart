import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:netflix_clone/app/config/theme/colors_config.dart';
import 'package:netflix_clone/app/core/data/mock_movies.dart';
import 'package:netflix_clone/app/model/movie_model.dart';
import 'package:netflix_clone/app/widgets/list_movie_widget.dart';
import 'package:netflix_clone/app/widgets/text_fild_form_widget.dart';
import 'package:netflix_clone/app/core/utils/responsive_size.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();

  final List<Movie> _allItems = mockMovies;
  late List<Movie> _filteredItems;

  @override
  void initState() {
    super.initState();
    _filteredItems = _allItems;
    _searchController.addListener(_filterItems);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterItems);
    _searchController.dispose();
    super.dispose();
  }

  void _filterItems() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredItems = _allItems.where((movie) {
        return movie.title.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveSize.init(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.responsiveWidth(16.0),
          ),
          child: Column(
            spacing: 10,
            children: [
              CustomTextFormField(
                controller: _searchController,
                hintText: 'Buscar filmes, séries...',
                isSearchField: true,
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.greyLight3,
                ),
                onChanged: (query) {},
              ),
              Expanded(
                child: _filteredItems.isNotEmpty
                    ? ListView.builder(
                        itemCount: _filteredItems.length,
                        itemBuilder: (context, index) {
                          final movie = _filteredItems[index];
                          return MovieListWidget(
                            movie: movie,
                            onPlayTap: () {
                              log(
                                'Tocando o filme: ${movie.title} ${movie.id}',
                              );
                            },
                          );
                        },
                      )
                    : const Center(
                        child: Text(
                          'Nenhum resultado encontrado.',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.greyLight3,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
