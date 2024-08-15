class RegistrationModel {
  String logo;
  String subtitle;
  String buttonText;
  String buttonType;
  List inputs;

  RegistrationModel(
      {required this.logo,
      required this.subtitle,
      required this.buttonType,
      required this.inputs,
      required this.buttonText});
}

List<RegistrationModel> registerPage = [
  RegistrationModel(
    logo: 'assets/img/logo.png',
    subtitle: 'Iltimos Telefon raqam va Parolingizni kiriting',
    buttonType: 'filled',
    inputs: [
      {'type': 'phone'},
      {'type': 'password'},
    ],
    buttonText: 'Kirish',
  ),
];
