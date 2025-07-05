import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix_clone/app/config/theme/colors_config.dart';
import 'package:netflix_clone/app/config/theme/text_style.dart';
import 'package:netflix_clone/app/features/started/widget/startde_widget.dart';
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
                  radius: 1.0,
                  colors: [AppColors.red, Colors.black],
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: MediaQuery.of(context).padding.top,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/images/netflix_icon_n.png', height: 40),
                    TextButton(
                      onPressed: () {
                        debugPrint('Entrar Pressed');
                        context.push('/login');
                      },
                      child: const Text('ENTRAR', style: AppTextStyles.black14),
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
                    children: [Started(), Started(), Started()],
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
                const SizedBox(height: 20),
                CustomButtonWidget(label: 'Vamos lá'),
              ],
            ),
          ),

          // Topo e botão inferior
        ],
      ),
    );
  }
}
