// ignore_for_file: prefer_final_fields, unused_field, unnecessary_new, prefer_const_constructors, file_names

import 'dart:core';

import 'package:flutter/material.dart';

class FormContainerWidget extends StatefulWidget {
  final TextEditingController? controller;
  final Key? fieldkey;
  final bool? isPasswordField;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType? inputeType;

  const FormContainerWidget(
      {super.key,
      this.controller,
      this.fieldkey,
      this.isPasswordField,
      this.hintText,
      this.labelText,
      this.helperText,
      this.onSaved,
      this.validator,
      this.inputeType,
      this.onFieldSubmitted});

  @override
  State<FormContainerWidget> createState() => _FormContainerWidgetState();
}

class _FormContainerWidgetState extends State<FormContainerWidget> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      height: 40,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 2, color: Color(0xFF9747FF)),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: new TextFormField(
        style: TextStyle(color: Colors.black),
        controller: widget.controller,
        keyboardType: widget.inputeType,
        key: widget.fieldkey,
        obscureText: widget.isPasswordField == true ? _obscureText : false,
        onSaved: widget.onSaved,
        validator: (value) {
          if (value!.isEmpty) {
            return "is empty!";
          }
          return null;
        },
        onFieldSubmitted: widget.onFieldSubmitted,
        decoration: new InputDecoration(
            border: InputBorder.none,
            filled: true,
            hintText: widget.hintText,
            hintStyle: TextStyle(color: Colors.grey),
            suffixIcon: new GestureDetector(
              onTap: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              child: widget.isPasswordField == true
                  ? Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color:
                          _obscureText == false ? Colors.purple : Colors.grey,
                    )
                  : Text(""),
            )),
      ),
    );
  }
}
