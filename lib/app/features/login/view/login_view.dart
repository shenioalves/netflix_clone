import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/app/widgets/custom_button_widget.dart';

Future<UserCredential> loginWithEmail(String email, String password) {
  return FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email,
    password: password,
  );
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: const Key('login_form'),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).padding.top,
            ),
            child: Column(
              children: [
                Row(
                  spacing: 10,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Image.asset('assets/images/netflix_logo.png', height: 35),
                  ],
                ),

                const SizedBox(height: 20),
                CustomButtonWidget(
                  label: 'Login',
                  onPressed: () async {
                    log('Login button pressed');
                    // Example usage of loginWithEmail
                    /*  try {
                      UserCredential userCredential = await loginWithEmail(
                        '<email>',
                        '<password>',
                      );
                    } catch (e) {
                      print('Login failed: $e');
                    }*/
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
