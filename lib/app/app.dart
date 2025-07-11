import 'package:flutter/material.dart';
import 'package:netflix_clone/app/config/routes.dart';
import 'package:netflix_clone/app/core/utils/responsive_size.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Netflix Clone',

      theme: ThemeData.dark(),
      builder: (context, child) {
        ResponsiveSize.init(context);
        return child!;
      },

      routerConfig: AppRouter.router,
    );
  }
}
