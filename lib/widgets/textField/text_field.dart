import 'package:flutter/material.dart';
import 'package:yolda/widgets/textField/text_field_model.dart';

class Input extends StatefulWidget {
  final String? placeholder;
  final String inputType;
  final String? Function(String?)? validator;

  const Input({
    super.key,
    this.placeholder = 'placeholder',
    required this.inputType,
    this.validator,
  });

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  bool _passwordVisible = true;
  late List inputTypeIs;

  @override
  void initState() {
    super.initState();

    // Initialize the inputTypeIs based on inputType
    if (widget.inputType == 'phone') {
      inputTypeIs = textFieldForPhoneNumber;
    } else if (widget.inputType == 'password') {
      inputTypeIs = textFieldForPassword;
    } else {
      inputTypeIs = [];
    }

    // Set password visibility only for password input type
    if (widget.inputType != 'password') {
      _passwordVisible = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: inputTypeIs.map((e) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SizedBox(
            height: 86,
            child: TextFormField(
              decoration: InputDecoration(
                filled: true,
                labelText: e.placeholder ?? widget.placeholder,
                labelStyle: TextStyle(
                  color: const Color(0xff3c4860).withOpacity(.7),
                  fontFamily: "Josefin Sans",
                  fontSize: 20,
                ),
                prefixIcon: e.prefixIcon != null && e.prefixIcon!.isNotEmpty
                    ? Image.asset(e.prefixIcon!)
                    : null,
                suffixIcon: e.suffixIcon != null && e.suffixIcon!.isNotEmpty
                    ? GestureDetector(
                        onTap: togglePassword,
                        child: _passwordVisible
                            ? Image.asset(e.suffixIcon!)
                            : Image.asset(e.changedSuffixIcon!),
                      )
                    : null,
                fillColor: const Color(0xff4c486b).withOpacity(.1),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(
                    color: const Color(0xff3c4860).withOpacity(0.3),
                  ),
                ),
                // errorStyle: const TextStyle(fontSize: 0),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: const Color(0xff3c4860).withOpacity(0.3),
                  ),
                ),
              ),
              keyboardType: e.keyboardType,
              obscureText:
                  widget.inputType == 'password' ? _passwordVisible : false,
              validator: e.validator,
            ),
          ),
        );
      }).toList(),
    );
  }

  void togglePassword() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }
}
