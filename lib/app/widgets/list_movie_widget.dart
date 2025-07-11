import 'package:flutter/material.dart';
import 'package:netflix_clone/app/config/theme/colors_config.dart';
import 'package:netflix_clone/app/core/utils/responsive_size.dart';
import 'package:netflix_clone/app/model/movie_model.dart';

class MovieListWidget extends StatelessWidget {
  final Movie movie;
  final VoidCallback? onPlayTap;

  const MovieListWidget({super.key, required this.movie, this.onPlayTap});

  Widget _buildImage() {
    final bool isNetworkImage = movie.posterUrl.startsWith('http');
    if (isNetworkImage) {
      return Image.network(
        movie.posterUrl,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            color: AppColors.greyDark1,
            child: const Center(child: CircularProgressIndicator()),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: AppColors.greyDark1,
            child: const Icon(Icons.movie, color: AppColors.grey),
          );
        },
      );
    } else {
      return Image.asset(
        movie.posterUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: AppColors.greyDark1,
            child: const Icon(Icons.broken_image, color: AppColors.grey),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageWidth = MediaQuery.of(context).size.width / 3.5;
    final iconSize = context.responsiveWidth(35);
    final titleFontSize = context.responsiveFont(14);
    final verticalPadding = context.responsiveHeight(8);

    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: verticalPadding),
      leading: SizedBox(
        width: imageWidth,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(context.responsiveWidth(4.0)),
          child: _buildImage(),
        ),
      ),
      title: Text(
        movie.title,
        style: TextStyle(
          color: AppColors.white,
          fontSize: titleFontSize,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.play_circle_outline,
          color: AppColors.white,
          size: iconSize,
        ),
        onPressed: onPlayTap,
      ),
      onTap: onPlayTap,
    );
  }
}
