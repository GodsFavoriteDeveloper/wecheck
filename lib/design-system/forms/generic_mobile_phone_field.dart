import 'package:flutter/material.dart';

class GenericMobilePhoneField extends StatelessWidget {
  GenericMobilePhoneField(
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

          if (val.length < 10) {
            return '$title should be at least 10 characters long';
          }

          if (double.tryParse(val) == null) {
            return 'Please enter a valid $title';
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
}
