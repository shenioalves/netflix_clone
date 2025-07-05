import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
//import 'package:firebase_auth/firebase_auth.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      // final user = FirebaseAuth.instance.currentUser;
      // if (user != null) {
      // ignore: use_build_context_synchronously
      context.go('/started');
      // } else {
      //   context.go('/login');
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Image.asset('assets/images/netflix_logo.png'),
        ),
      ),
    );
  }
}
