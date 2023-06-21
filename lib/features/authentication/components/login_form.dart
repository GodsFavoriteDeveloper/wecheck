import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecheck/design-system/buttons/primary_btn.dart';
import 'package:wecheck/design-system/tokens.dart';
import 'package:wecheck/features/authentication/auth_provider.dart';
import 'package:wecheck/features/authentication/screens/register_screen.dart';
import 'package:wecheck/features/dashboard/dashboard_screen.dart';
import 'package:wecheck/shared/general.dart';
import 'dart:html' as html;

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _usernameController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var username;
  var password;
  var isLoading = false;

  bool isPasswordHidden = true;

  TextFormField _buildUsernameField() {
    return TextFormField(
      validator: (val) {
        if (val!.isEmpty) {
          return 'Email cannot be empty';
        }

        if (val.length < 4) {
          return 'Email should be at least 4 characaters long';
        }

        return null;
      },
      controller: _usernameController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onSaved: (val) {
        username = val;
      },
      focusNode: _usernameFocusNode,
      decoration: InputDecoration(
        suffixIcon: Icon(
          Icons.person_outlined,
          color: Theme.of(context).primaryColor,
        ),
        labelText: 'Email',
      ),
    );
  }

  TextFormField _buildPasswordField() {
    return TextFormField(
      validator: (val) {
        if (val!.isEmpty) {
          return 'Password cannot be empty';
        }

        if (val.length < 6) {
          return 'Password should be at least 6 characaters long';
        }

        return null;
      },
      onSaved: (val) {
        password = val;
      },
      focusNode: _passwordFocusNode,
      obscureText: isPasswordHidden,
      enableSuggestions: false,
      autocorrect: false,
      style: const TextStyle(color: Colors.black),
      // keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                isPasswordHidden = !isPasswordHidden;
              });
            },
            icon: Icon(isPasswordHidden
                ? Icons.remove_red_eye
                : Icons.remove_red_eye_outlined),
            color: Theme.of(context).primaryColor),
        labelText: 'Password',
      ),
    );
  }

  Widget _buildSignInButton() {
    return PrimaryBtn(
        btnColor: DesignSystem.GEMSBlue,
        btnTitle: "Sign In",
        btnRadius: 10,
        btnCallbackFn: () {
          _loginUser(context);
        });
  }

  Widget _buildRegisterButton() {
    return PrimaryBtn(
        btnColor: DesignSystem.WecheckBrown,
        btnTitle: "Register",
        btnRadius: 10,
        btnCallbackFn: () {
          navigateViaMaterialRoute(context, RegisterScreen());
        });
  }

  Widget _buildLogo() {
    return Image.asset(
      "assets/img/wecheck_logo_light.png",
      width: 400,
    );
  }

  presentDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message),
          // content: Text(message),
          actions: <Widget>[
            ElevatedButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _loginUser(context) async {
    final isValid = _form.currentState!.validate();
    print(isValid);
    if (isValid) {
      setState(() {
        isLoading = true;
      });
      _form.currentState!.save();
      try {
        var result =
            await Provider.of<AuthProvider>(context, listen: false).login(
          email: username,
          password: password,
        );
        print(result);

        navigateViaMaterialRoute(
          context,
          DashboardScreen(),
          replace: true,
        );
        html.window.location.reload();
        setState(() {
          isLoading = false;
        });
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        presentDialog(e.toString());

        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            child: Center(child: CircularProgressIndicator()),
          )
        : Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Material(
              color: Colors.white,
              child: Form(
                key: _form,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildLogo(),
                      SizedBox(height: 50),
                      _buildUsernameField(),
                      SizedBox(height: 20),
                      _buildPasswordField(),
                      SizedBox(height: 20),
                      _buildSignInButton(),
                      SizedBox(height: 5),
                      _buildRegisterButton(),
                    ]),
              ),
            ));
  }
}
