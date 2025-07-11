import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix_clone/app/config/theme/text_style.dart';
import 'package:netflix_clone/app/core/services/auth_servise.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    return TextButton(
      onPressed: () async {
        await authService.signOut();
        if (context.mounted) {
          context.go('/started');
        }
      },
      child: Text('LOG OUT', style: AppTextStyles.boldDisplay32),
    );
  }
}
