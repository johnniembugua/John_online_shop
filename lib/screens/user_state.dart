import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app2/screens/landing_page.dart';
import 'package:shopping_app2/screens/main_screen.dart';

class UserState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        // ignore: missing_return
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (userSnapshot.connectionState == ConnectionState.active) {
            if (userSnapshot.hasData) {
              print('User is already logged in');
              return MainScreen();
            } else {
              print('User didnt log in yet');
              return LandingPage();
            }
          } else if (userSnapshot.hasError) {
            return Center(
              child: Text('Error Occured'),
            );
          }
        });
  }
}
