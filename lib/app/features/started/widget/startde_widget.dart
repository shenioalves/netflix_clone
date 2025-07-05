import 'package:flutter/material.dart';
import 'package:netflix_clone/app/config/theme/colors_config.dart';
import 'package:netflix_clone/app/config/theme/text_style.dart';

class Started extends StatelessWidget {
  const Started({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.greyDark3, AppColors.greyDark1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          border: Border.all(color: AppColors.greyLight3, width: 1.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset('assets/images/init.png'),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  height: MediaQuery.of(context).size.height / 10,
                  width: double.infinity,
                  // color: AppColors.greyDark2,
                ),
              ],
            ),

            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,

                    stops: [0.1, 1],
                    colors: [AppColors.greyDark3, Colors.transparent],
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: 0,
              child: Column(
                spacing: 10,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Filmes, séries e muito\nmais, sem limites.',
                    style: AppTextStyles.medium26.copyWith(
                      color: AppColors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  Text(
                    'Assista onde quiser. Cancele quando quiser.',
                    style: AppTextStyles.medium14.copyWith(
                      color: AppColors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
