import 'package:flutter/material.dart';

class GenericTextPhoneField extends StatelessWidget {
  GenericTextPhoneField(
      {Key? key,
      required this.controller,
      required this.title,
      this.validatorsFn})
      : super(key: key);

  TextEditingController controller;
  String? title;
  Function? validatorsFn;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        validator: (val) {
          if (val!.isEmpty) {
            return '$title cannot be empty';
          }
          return null;
        },
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
            // borderRadius: BorderRadius.circular(25.0),
          ),
          labelText: title,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  _buildValidators(val) {
    if (val!.isEmpty) {
      return '$title cannot be empty';
    }
    return null;
  }
}
