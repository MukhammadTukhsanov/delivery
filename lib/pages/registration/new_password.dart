import 'package:flutter/material.dart';
import 'package:yolda/pages/registration/registration.dart';
import 'package:yolda/pages/registration/registration_model.dart';
import 'package:yolda/widgets/button/button.dart';
import 'package:yolda/widgets/textField/text_field.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final GlobalKey<FormState> _registerKey = GlobalKey<FormState>();

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
                children: newPasswordPage.map((e) {
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
                        ...e.inputs.map((input) {
                          return Input(
                            inputType: input['type'],
                            placeholder: input['text'],
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
                          onPressed: () {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_registerKey.currentState!.validate()) {
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Processing Data')),
                              );
                            }
                          },
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
}
