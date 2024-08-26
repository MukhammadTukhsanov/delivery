import 'package:flutter/material.dart';
import 'package:yolda/controllers/auth_service.dart';
import 'package:yolda/pages/home/home.dart';
import 'package:yolda/pages/registration/registration.dart';
import 'package:yolda/pages/registration/registration_model.dart';
import 'package:yolda/pages/registration/send_sms.dart';
import 'package:yolda/widgets/button/button.dart';
import 'package:yolda/widgets/textField/text_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  final List<TextEditingController> _loginPageControllers =
      List.generate(2, (_) => TextEditingController());

  @override
  void dispose() {
    // Dispose controllers
    for (var controller in _loginPageControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_loginKey.currentState!.validate()) {
      try {
        // Show a loading indicator
        if (mounted) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) =>
                const Center(child: CircularProgressIndicator()),
          );
        }

        // Attempt to log in
        await AuthService.loginUser(
          phoneNumber: _loginPageControllers[0].text,
          password: _loginPageControllers[1].text,
        );

        // Close the loading indicator
        if (mounted) {
          Navigator.of(context).pop(); // Close the progress indicator dialog
        }

        // Navigate to the HomePage and show a success snackbar
        if (mounted) {
          // Navigator.of(context).pushAndRemoveUntil(
          //     MaterialPageRoute(builder: (context) => HomePage()),
          //     (Route<dynamic> route) => false);
          AuthService.onLoginSuccess(context, _loginPageControllers[0].text);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login Successful')),
          );
        }
      } catch (e) {
        // Close the loading indicator
        if (mounted) {
          Navigator.of(context).pop(); // Close the progress indicator dialog
        }

        // Handle specific login errors
        String errorMessage;
        if (e is AuthException) {
          print('code: ${e.code}, message: ${e.message}');
          switch (e.code) {
            case 'user-not-found':
              errorMessage = 'User not found. Please check your phone number.';
              break;
            case 'wrong-password':
              errorMessage = 'Incorrect password. Please try again.';
              break;
            case 'unknown-error':
            default:
              errorMessage =
                  'An unknown error occurred. Please try again later.';
              break;
          }
        } else {
          errorMessage = 'An unexpected error occurred. Please try again.';
        }

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage)),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Form(
              key: _loginKey,
              child: Center(
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16.0),
                  children: loginPage.map((e) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            e.logo,
                            width: screenSize.width * 0.45,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            e.subtitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'Josefin Sans',
                              color: const Color(0xff3C486B).withOpacity(0.7),
                            ),
                          ),
                          const SizedBox(height: 16),
                          ...e.inputs.asMap().entries.map((entry) {
                            int index = entry.key;
                            var input = entry.value;
                            return Input(
                              inputType: input['type'],
                              placeholder: input['text'],
                              controller: _loginPageControllers[index],
                              // Add validation if necessary
                            );
                          }),
                          if (e.textWithLink != null)
                            Transform.translate(
                              offset: Offset(screenSize.width / 2 - 125, -18),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SendSms()));
                                },
                                child: Text(
                                  e.textWithLink!,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Josefin Sans',
                                    color: const Color(0xff3C486B)
                                        .withOpacity(0.7),
                                  ),
                                ),
                              ),
                            ),
                          Button(
                            type: e.buttonType,
                            text: e.buttonText,
                            onPressed: _handleLogin,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                e.textAndLinkedText!['text'],
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Josefin Sans',
                                  color:
                                      const Color(0xff3C486B).withOpacity(0.7),
                                ),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Registration()));
                                },
                                child: Text(
                                  e.textAndLinkedText!['linkedText'],
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Josefin Sans',
                                    color: const Color(0xffff9556)
                                        .withOpacity(0.7),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
