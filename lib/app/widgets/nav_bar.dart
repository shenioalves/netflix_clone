// scaffold_with_nav_bar.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix_clone/app/config/theme/colors_config.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavBar({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // O corpo agora é o widget navigationShell, que contém a view da aba atual
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        // O índice atual é obtido diretamente do navigationShell
        currentIndex: navigationShell.currentIndex,
        selectedItemColor: AppColors.blue,
        unselectedItemColor: AppColors.greyLight1,
        backgroundColor: AppColors.background,
        type: BottomNavigationBarType.fixed,
        // O onTap agora usa o método goBranch para trocar de aba
        onTap: (index) {
          navigationShell.goBranch(
            index,
            // volta para a primeira página da aba se já estiver nela
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
          BottomNavigationBarItem(
            icon: Icon(Icons.download),
            label: 'Downloads',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}
