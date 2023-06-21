import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecheck/design-system/buttons/primary_btn.dart';
import 'package:wecheck/design-system/forms/generic_text_field.dart';
import 'package:wecheck/design-system/tokens.dart';
import 'package:wecheck/features/authentication/auth_provider.dart';
import 'package:wecheck/features/authentication/screens/login_screen.dart';
import 'package:wecheck/features/authentication/screens/register_screen.dart';
import 'package:wecheck/features/dashboard/dashboard_screen.dart';
import 'package:wecheck/shared/general.dart';
import 'dart:html' as html;

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _passwordFocusNode = FocusNode();
  final _fullNameController = TextEditingController();
  final _emailAddressController = TextEditingController();
  final _passwordController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var username;
  var password;
  var isLoading = false;

  bool isPasswordHidden = true;

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
      controller: _passwordController,
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

  _buildFullNameField() {
    return GenericTextField(
      controller: _fullNameController,
      title: "Full Name",
    );
  }

  _buildEmailAddressField() {
    return GenericTextField(
      controller: _emailAddressController,
      title: "Email Address",
    );
  }

  Widget _buildSignInButton() {
    return PrimaryBtn(
        btnColor: DesignSystem.GEMSBlue,
        btnTitle: "Register",
        btnRadius: 10,
        btnCallbackFn: () {
          _registerUser(context);
        });
  }

  Widget _buildRegisterButton() {
    return PrimaryBtn(
        btnColor: DesignSystem.WecheckBrown,
        btnTitle: "Login",
        btnRadius: 10,
        btnCallbackFn: () {
          navigateViaMaterialRoute(
            context,
            DashboardScreen(),
            replace: true,
          );
          html.window.location.reload();
          setState(() {
            isLoading = false;
          });
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

  _registerUser(context) async {
    final isValid = _form.currentState!.validate();
    print(isValid);
    if (isValid) {
      setState(() {
        isLoading = true;
      });
      _form.currentState!.save();
      try {
        var result = await Provider.of<AuthProvider>(context, listen: false)
            .registerUser(
                email: _emailAddressController.text,
                password: _passwordController.text,
                fullName: _fullNameController.text);
        print(result);

        setState(() {
          isLoading = false;
        });

        // Navigator.of(context).pushNamed("/dashboard");
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
                      _buildFullNameField(),
                      // SizedBox(height: 20),
                      _buildEmailAddressField(),
                      // SizedBox(height: 20),
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
