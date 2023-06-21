import 'package:flutter/material.dart';
import 'package:wecheck/design-system/tokens.dart';
import 'package:wecheck/features/authentication/screens/login_screen.dart';
import 'package:wecheck/features/authentication/screens/register_screen.dart';
import 'package:wecheck/shared/general.dart';

class WebNavBar extends StatelessWidget {
  const WebNavBar({Key? key}) : super(key: key);

  Widget _buildLogo() {
    return Image.asset(
      "assets/img/wecheck_logo_light.png",
      height: 50,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        _buildLogo(),
        Row(children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Text("Home"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: InkWell(
                  onTap: () =>
                      navigateViaMaterialRoute(context, const LoginScreen()),
                  child: const Text(
                    "Login",
                    style: TextStyle(color: Colors.black),
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: InkWell(
                  onTap: () =>
                      navigateViaMaterialRoute(context, const RegisterScreen()),
                  child: const Text(
                    "Register",
                    style: TextStyle(color: Colors.black),
                  ),
                )),
          ),
        ])
      ]),
    );
  }
}

class MobileNavBar extends StatelessWidget {
  const MobileNavBar({Key? key}) : super(key: key);

  Widget _buildLogo() {
    return const Icon(Icons.menu);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Container(
        padding: const EdgeInsets.only(left: 30),
        child: Image.asset(
          "assets/img/wecheck_logo_light.png",
          // height: 50,
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/login");
            },
            icon: const Icon(Icons.login))
      ],
    );
  }
}
