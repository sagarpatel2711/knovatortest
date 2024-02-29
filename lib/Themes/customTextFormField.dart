import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  var controller;
  String? hinttext;
  String? labeltext;

  FormFieldValidator<String>? validator;
  TextInputType? keyboardType;
  bool? obscureText;
  IconButton? iconbutton;
  List<TextInputFormatter>? inputFormatters;
  Function(String)? onFieldSubmitted;
  Widget? prefix;
  bool borderNone;

  CustomTextFormField(
      {super.key,
      this.controller,
      this.hinttext,
      this.keyboardType,
      this.labeltext,
      this.validator,
      this.obscureText,
      this.iconbutton,
      this.inputFormatters,
      this.onFieldSubmitted,
      this.prefix,
      this.borderNone = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatters,
      style: Get.theme.textTheme.labelMedium,
      obscureText: obscureText!,
      controller: controller,
      onFieldSubmitted: onFieldSubmitted,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
          hintText: hinttext,
          prefix: prefix,
          labelText: labeltext,
          suffixIcon: iconbutton,
          labelStyle:
              TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black),
          enabledBorder: borderNone
              ? InputBorder.none
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Get.theme.dividerColor,
                    width: 0.5,
                  ),
                ),
          border: borderNone
              ? InputBorder.none
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Get.theme.dividerColor,
                    width: 0.5,
                  ),
                ),
          focusedBorder: borderNone
              ? InputBorder.none
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Get.theme.dividerColor,
                    width: 0.5,
                  ))),
      validator: validator,
      keyboardType: keyboardType,
    );
  }
}
