import 'package:flutter/material.dart';

String? originalPassword;

class TextfieldModel {
  final String type;
  final String? prefixIcon;
  final String? suffixIcon;
  final String? changedSuffixIcon;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  TextfieldModel({
    required this.type,
    this.prefixIcon,
    this.suffixIcon,
    this.changedSuffixIcon,
    this.validator,
    required this.keyboardType,
  });
}

// Default TextField
final List<TextfieldModel> textFieldDefault = [
  TextfieldModel(
    type: 'default',
    keyboardType: TextInputType.name,
  ),
];

// UserName TextField
final List<TextfieldModel> textFieldForUserName = [
  TextfieldModel(
    type: 'name',
    prefixIcon: 'assets/img/person.png',
    keyboardType: TextInputType.name,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Iltimos yozuv kiriting';
      } else if (value.length < 2) {
        return 'Iltimos 2 dan ortiq harf kiriting.';
      }
      return null;
    },
  ),
];

// PhoneNumber TextField
final List<TextfieldModel> textFieldForPhoneNumber = [
  TextfieldModel(
    type: 'phone',
    prefixIcon: 'assets/img/phone.png',
    keyboardType: TextInputType.phone,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Iltimos telefon raqam kiriting';
      } else if (!RegExp(r'^\+998\d{9}$').hasMatch(value)) {
        return "Iltimos to'g'ri formatda kiriting.";
      }
      return null;
    },
  ),
];

// Password TextField
final List<TextfieldModel> textFieldForPassword = [
  TextfieldModel(
    type: 'password',
    prefixIcon: 'assets/img/lock.png',
    suffixIcon: 'assets/img/eye-open.png',
    changedSuffixIcon: 'assets/img/eye-closed.png',
    keyboardType: TextInputType.text,
    validator: (value) {
      originalPassword = value;
      if (value == null || value.isEmpty) {
        return 'Iltimos yozuv kiriting';
      } else if (value.length < 6) {
        return 'Iltimos 6 dan ortiq harf kiriting.';
      }
      return null;
    },
  ),
];

// Confirm Password TextField
final List<TextfieldModel> textFieldForConfirmPassword = [
  TextfieldModel(
    type: 'confirmPassword',
    prefixIcon: 'assets/img/lock.png',
    suffixIcon: 'assets/img/eye-open.png',
    changedSuffixIcon: 'assets/img/eye-closed.png',
    keyboardType: TextInputType.text,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Iltimos yozuv kiriting';
      } else if (value != originalPassword) {
        return 'Parollar mos kelmadi';
      }
      return null;
    },
  ),
];
