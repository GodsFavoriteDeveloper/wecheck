import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wecheck/features/authentication/screens/register_screen.dart';
import 'package:wecheck/features/dashboard/dashboard_screen.dart';
import 'package:wecheck/features/landing-page/landing_page_screen.dart';
import '../features/authentication/screens/login_screen.dart';

Map<String, Widget Function(BuildContext)> routes(context) {
  User? user = FirebaseAuth.instance.currentUser;
  print(user);
  return {
    '/': (context) {
      if (user != null) {
        return DashboardScreen();
      } else {
        return LandingPageScreen();
      }
    },
    "/login": (context) => LoginScreen(),
  };
}
