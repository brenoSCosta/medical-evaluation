import 'package:flutter/material.dart';
import 'package:avaliacao_medica/app/styleguide/colors.dart' as colorsProject;

class TextFieldForm extends StatelessWidget {
  final hintText;
  final icone;
  final onChange;
  final validador;
  final inputType;
  final onTap;
  final controller;
  final bool readOnly;
  final Color hintTextColor;
  final suffixIcon;
  final inputFormatters;

  const TextFieldForm(
      {this.hintText,
      this.icone,
      this.onChange,
      this.validador,
      this.inputType,
      this.onTap,
      this.controller,
      this.readOnly = false,
      this.suffixIcon,
      this.hintTextColor = Colors.black,
      this.inputFormatters,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        this.onChange(value);
      },
      controller: controller,
      onTap: onTap,
      validator: validador,
      readOnly: readOnly,
      keyboardType: inputType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        errorStyle: TextStyle(fontSize: 15),
        hintText: hintText,
        hintStyle: TextStyle(color: hintTextColor),
        prefixIcon: icone,
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorsProject.primaryColor, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorsProject.primaryColor, width: 2.3),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: new OutlineInputBorder(
          borderSide:
              new BorderSide(color: colorsProject.primaryColor, width: 1.5),
        ),
        focusedErrorBorder: new OutlineInputBorder(
          borderSide:
              new BorderSide(color: colorsProject.primaryColor, width: 2.3),
        ),
      ),
    );
  }
}
