import 'package:flutter/material.dart';

class GenericTextField extends StatelessWidget {
  GenericTextField({Key? key, required this.controller, required this.title})
      : super(key: key);

  TextEditingController controller;
  String title;
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Form(
        key: _form,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: TextFormField(
          controller: controller,
          validator: (val) {
            if (val!.isEmpty) {
              return '$title field cannot be empty';
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
      ),
    );
  }
}
