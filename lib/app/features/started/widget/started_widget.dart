import 'package:flutter/material.dart';
import 'package:netflix_clone/app/config/theme/colors_config.dart';
import 'package:netflix_clone/app/config/theme/text_style.dart';
import 'package:netflix_clone/app/core/utils/responsive_size.dart';

class Started extends StatelessWidget {
  const Started({super.key});

  @override
  Widget build(BuildContext context) {
    final BorderRadius borderRadius = BorderRadius.circular(8.0);
    return Padding(
      padding: EdgeInsets.only(top: ResponsiveSize.height(10)),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey, width: 2),
          borderRadius: borderRadius,
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: borderRadius,
                  child: Image.asset('assets/images/init.png'),
                ),
                Container(
                  decoration: BoxDecoration(borderRadius: borderRadius),
                  height: MediaQuery.of(context).size.height / 10,
                  width: double.infinity,
                ),
              ],
            ),

            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: [0.1, 1],
                    colors: [AppColors.greyDark1, Colors.transparent],
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: 10,
              child: Column(
                spacing: 10,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Filmes, séries e muito\nmais, sem limites.',
                    style: AppTextStyles.mediumDisplay32.copyWith(
                      color: AppColors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  Text(
                    'Assista onde quiser. Cancele quando quiser.',
                    style: AppTextStyles.lightTitle16.copyWith(
                      color: AppColors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
