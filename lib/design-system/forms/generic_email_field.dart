import 'package:flutter/material.dart';

class GenericEmailField extends StatelessWidget {
  GenericEmailField(
      {Key? key,
      required this.controller,
      required this.title,
      this.isReadOnly})
      : super(key: key);

  TextEditingController controller;
  String? title;
  bool? isReadOnly;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        readOnly: isReadOnly ?? false,
        validator: (val) {
          if (val!.isEmpty) {
            return '$title cannot be empty';
          }

          String pattern =
              r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
              r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
              r"{0,253}[a-zA-Z0-9])?)*$";
          RegExp regex = RegExp(pattern);

          if (!regex.hasMatch(val)) {
            return '$title is invalid';
          }

          return null;
        },
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
            // borderRadius: BorderRadius.circular(25.0),
          ),
          labelText: title ?? 'Email Address',
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
