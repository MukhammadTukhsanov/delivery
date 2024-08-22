import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:yolda/controllers/auth_service.dart';
import 'package:yolda/pages/registration/confirm_sms_code.dart';
import 'package:yolda/pages/registration/registration.dart';
import 'package:yolda/pages/registration/registration_model.dart';
import 'package:yolda/widgets/button/button.dart';
import 'package:yolda/widgets/textField/text_field.dart';

class SendSms extends StatefulWidget {
  const SendSms({super.key});

  @override
  State<SendSms> createState() => _SendSmsState();
}

class _SendSmsState extends State<SendSms> {
  final GlobalKey<FormState> _registerKey = GlobalKey<FormState>();
  String _verificationId = "";
  final List<TextEditingController> _phoneNumberController =
      List.generate(1, (_) => TextEditingController());

  sendOTP() {
    // AuthService.sendOtp(phone: _phoneNumberController[0].text, onCodeSent: )
  }

  @override
  void dispose() {
    for (var _ in _phoneNumberController) {
      _.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Form(
            key: _registerKey,
            child: Center(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(16.0),
                children: sendSmsPage.map((e) {
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
                            controller: _phoneNumberController[index],
                          );
                        }),
                        if (e.textWithLink != null)
                          Transform.translate(
                            offset: Offset(screenSize.width / 2 - 125, -18),
                            child: GestureDetector(
                              onTap: () {},
                              child: Text(
                                e.textWithLink!,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Josefin Sans',
                                  color:
                                      const Color(0xff3C486B).withOpacity(0.7),
                                ),
                              ),
                            ),
                          ),
                        Button(
                          type: e.buttonType,
                          text: e.buttonText,
                          onPressed: _sendOTP,
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
                                color: const Color(0xff3C486B).withOpacity(0.7),
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
                                  color:
                                      const Color(0xffff9556).withOpacity(0.7),
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
    );
  }

  void _sendOTP() async {
    String phoneNumber = _phoneNumberController[0].text.trim();

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-resolve or auto-sign-in if the OTP is automatically detected
      },
      verificationFailed: (FirebaseAuthException e) {
        print("Verification failed: ${e.message}");
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _verificationId = verificationId;
        });
        print("Verification code sent to $phoneNumber");
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          _verificationId = verificationId;
        });
      },
    );
  }
}
