import 'package:flutter/material.dart';

class RegistrationModel {
  String logo;
  String subtitle;
  String buttonText;
  String buttonType;
  String? textWithLink;
  List inputs;
  Map? textAndLinkedText;
  List? codeInputs;

  RegistrationModel(
      {required this.logo,
      required this.subtitle,
      required this.buttonType,
      required this.buttonText,
      this.textWithLink,
      this.textAndLinkedText,
      required this.inputs,
      this.codeInputs});
}

List<RegistrationModel> loginPage = [
  RegistrationModel(
    logo: 'assets/img/logo.png',
    subtitle: 'Iltimos Telefon raqam va Parolingizni kiriting',
    buttonType: 'filled',
    inputs: [
      {'type': 'phone', 'text': 'Telefon raqam'},
      {'type': 'password', 'text': 'Paroll kiriting'},
    ],
    textWithLink: 'Parollni unuttingizmi?',
    textAndLinkedText: {
      'text': "Akkountingiz yo'qmi?",
      'linkedText': "Ro'yxatdan o'tish"
    },
    buttonText: 'Kirish',
  ),
];
List<RegistrationModel> registerPage = [
  RegistrationModel(
    logo: 'assets/img/logo.png',
    subtitle: 'Iltimos Telefon raqam va Parolingizni kiriting',
    buttonType: 'filled',
    inputs: [
      {'type': 'name', 'text': 'Ism va Familya'},
      {'type': 'phone', 'text': 'Telefon raqam'},
      {'type': 'password', 'text': 'Paroll kiriting'},
      {'type': 'password', 'text': 'Parollni tasdiqlang'},
    ],
    // textWithLink: 'Parollni unuttingizmi?',
    textAndLinkedText: {'text': "Akkountingiz bormi?", 'linkedText': "Kirish"},
    buttonText: "Ro'yxatdan o'tish",
  ),
];
List<RegistrationModel> sendSmsPage = [
  RegistrationModel(
    logo: 'assets/img/logo.png',
    subtitle: "Parolingizni unutdingizmi? Ro'yxatdan o'tilgan raqamni kiriting",
    buttonType: 'filled',
    inputs: [
      {'type': 'phone', 'text': 'Telefon raqam'},
    ],
    textAndLinkedText: {'text': "Akkountingiz bormi?", 'linkedText': "Kirish"},
    buttonText: "SMS Jo'natish",
  ),
];
List<RegistrationModel> newPasswordPage = [
  RegistrationModel(
    logo: 'assets/img/logo.png',
    subtitle: "Yangi parol kiriting!",
    buttonType: 'filled',
    inputs: [
      {'type': 'password', 'text': 'Paroll kiriting'},
      {'type': 'password', 'text': 'Parollni tasdiqlang'},
    ],
    // textAndLinkedText: {'text': "Akkountingiz bormi?", 'linkedText': "Kirish"},
    buttonText: "Tasdiqlash",
  ),
];

List<RegistrationModel> confirmSmsCodePage = [
  RegistrationModel(
    logo: 'assets/img/logo.png',
    subtitle: "Parolingizni unutdingizmi? Ro'yxatdan o'tilgan raqamni kiriting",
    buttonType: 'filled',
    inputs: [
      {
        'type': 'phone',
        'text': '+998 94 123 45 67',
        'enabled': false,
        'controller': TextEditingController(text: '+998 94 123 45 67')
      },
    ],
    codeInputs: [
      {'type': 'default', 'text': '', 'controller': TextEditingController()},
      {'type': 'default', 'text': '', 'controller': TextEditingController()},
      {'type': 'default', 'text': '', 'controller': TextEditingController()},
      {'type': 'default', 'text': '', 'controller': TextEditingController()},
    ],
    textAndLinkedText: {'text': "Akkountingiz bormi?", 'linkedText': "Kirish"},
    buttonText: "SMS Jo'natish",
  ),
];
