import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:netflix_clone/app/config/firebase_options.dart';
import 'package:netflix_clone/app/config/routes.dart';
import 'package:netflix_clone/app/config/theme/theme_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Netflix Clone',
      theme: AppTheme.darkTheme,
      routerConfig: AppRouter.router,
    );
  }
}
