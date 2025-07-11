import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix_clone/app/config/theme/colors_config.dart';
import 'package:netflix_clone/app/config/theme/text_style.dart';
import 'package:netflix_clone/app/core/utils/responsive_size.dart';
import 'package:netflix_clone/app/features/started/widget/started_widget.dart';
import 'package:netflix_clone/app/widgets/custom_button_widget.dart';

class StartedView extends StatelessWidget {
  final PageController _pageController = PageController();
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);
  StartedView({super.key});

  @override
  Widget build(BuildContext context) {
    Color changeColor({int value = 0, int position = 0}) {
      if (value == position) {
        return AppColors.greyLight3;
      } else {
        return AppColors.grey;
      }
    }

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.bottomCenter,
                  radius: 5,
                  stops: [0.0, 0.1, 0.3],
                  colors: [AppColors.blue, AppColors.blueDark3, Colors.black],
                ),
              ),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: _currentIndex,
            builder: (context, value, child) {
              return value == 1
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).padding.top + 70.0,
                        horizontal: ResponsiveSize.width(10),
                      ),
                      child: Image.asset('assets/images/init.png'),
                    )
                  : SizedBox.shrink();
            },
          ),

          Padding(
            padding: EdgeInsets.symmetric(
              vertical: ResponsiveSize.paddingTop,
              horizontal: ResponsiveSize.width(10),
            ),
            child: Column(
              spacing: ResponsiveSize.height(10),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: ResponsiveSize.height(30),
                      child: Image.asset(
                        'assets/images/icon.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        debugPrint('Entrar Pressed');
                        context.push('/login');
                      },
                      child: Text('ENTRAR', style: AppTextStyles.mediumTitle16),
                    ),
                  ],
                ),

                Expanded(
                  child: PageView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    controller: _pageController,
                    onPageChanged: (index) {
                      _currentIndex.value = index;
                    },
                    children: [
                      Started(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .6,
                          ),
                          SizedBox(height: 10),
                          //Image.asset('assets/images/init.png'),
                          Text(
                            'A fim de deviersão ilimitadas?',
                            style: AppTextStyles.mediumHeadline18.copyWith(
                              color: AppColors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Row(
                            children: [
                              Icon(Icons.check, color: AppColors.blue),
                              SizedBox(width: 4),
                              Text(
                                'Assista a filmes e séries offline',
                                style: AppTextStyles.mediumBody14.copyWith(
                                  color: AppColors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.check, color: AppColors.blue),
                              SizedBox(width: 4),
                              Text(
                                'Novos lançamentos adicionados toda semana',
                                style: AppTextStyles.mediumBody14.copyWith(
                                  color: AppColors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.check, color: AppColors.blue),
                              SizedBox(width: 4),
                              Text(
                                'Cancele quando quiser',
                                style: AppTextStyles.mediumBody14.copyWith(
                                  color: AppColors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Started(),
                    ],
                  ),
                ),

                ValueListenableBuilder(
                  valueListenable: _currentIndex,
                  builder: (context, value, child) {
                    return Row(
                      spacing: 5,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.circle,
                          size: 10,
                          color: changeColor(value: value, position: 0),
                        ),

                        Icon(
                          Icons.circle,
                          size: 10,
                          color: changeColor(value: value, position: 1),
                        ),

                        Icon(
                          Icons.circle,
                          size: 10,
                          color: changeColor(value: value, position: 2),
                        ),
                      ],
                    );
                  },
                ),

                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withAlpha(50),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: CustomButtonWidget(
                    label: 'Vamos lá',
                    onPressed: () {
                      debugPrint('Vamos lá Pressed');
                      context.push('/register');
                    },
                  ),
                ),
              ],
            ),
          ),

          // Topo e botão inferior
        ],
      ),
    );
  }
}
