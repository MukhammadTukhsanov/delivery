import 'package:flutter/material.dart';

class TextfieldModel {
  String type;
  String? prefixIcon;
  String? suffixIcon;
  String? changedSuffixIcon;
  String? Function(String?)? validator;
  TextInputType keyboardType;

  TextfieldModel(
      {required this.type,
      this.prefixIcon,
      this.suffixIcon,
      this.changedSuffixIcon,
      this.validator,
      required this.keyboardType});
}

List<TextfieldModel> textFieldDefault = [
  TextfieldModel(
      type: 'default',
      // prefixIcon: 'assets/img/person.png',
      // validator: (value) {
      //   if (value == null || value.isEmpty) {
      //     return 'Please enter some text';
      //   } else if (value.length < 6) {
      //     return 'Please enter at least 6 characters';
      //   }
      //   return null;
      // },
      keyboardType: TextInputType.name)
];
List<TextfieldModel> textFieldForUserName = [
  TextfieldModel(
      type: 'name',
      prefixIcon: 'assets/img/person.png',
      // validator: (value) {
      //   if (value == null || value.isEmpty) {
      //     return 'Please enter some text';
      //   } else if (value.length < 6) {
      //     return 'Please enter at least 6 characters';
      //   }
      //   return null;
      // },
      keyboardType: TextInputType.name)
];
List<TextfieldModel> textFieldForPhoneNumber = [
  TextfieldModel(
      type: 'phone',
      prefixIcon: 'assets/img/phone.png',
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        } else if (value.length < 6) {
          return 'Please enter at least 6 characters';
        }
        return null;
      },
      keyboardType: TextInputType.phone)
];
List<TextfieldModel> textFieldForPassword = [
  TextfieldModel(
      type: 'password',
      prefixIcon: 'assets/img/lock.png',
      suffixIcon: 'assets/img/eye-open.png',
      changedSuffixIcon: 'assets/img/eye-closed.png',
      keyboardType: TextInputType.text)
];
List<TextfieldModel> textFieldForConfirmPassword = [
  TextfieldModel(
      type: 'password',
      prefixIcon: 'assets/img/lock.png',
      suffixIcon: 'assets/img/eye-open.png',
      changedSuffixIcon: 'assets/img/eye-closed.png',
      keyboardType: TextInputType.phone)
];
