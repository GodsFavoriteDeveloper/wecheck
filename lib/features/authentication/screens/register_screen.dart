import 'package:flutter/material.dart';
import 'package:wecheck/features/authentication/screens/web_register_screen.dart';
import 'package:wecheck/shared/responsive.dart';
import 'web_login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Responsive(
          mobile: WebRegisterScreen(
            isMobile: true,
          ),
          desktop: WebRegisterScreen(
            isMobile: false,
          )),
    );
  }
}
