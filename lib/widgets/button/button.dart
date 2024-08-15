import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final String type;

  const Button(
      {super.key,
      required this.text,
      required this.onPressed,
      this.icon,
      required this.type});

  @override
  ButtonState createState() => ButtonState();
}

class ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor:
              widget.type == 'filled' ? const Color(0xffff9556) : null,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
      onPressed: widget.onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              widget.text,
              style: TextStyle(
                fontFamily: 'Josefin Sans',
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: widget.type == 'filled'
                    ? Colors.white
                    : const Color(0xffFF9556),
              ),
            ),
          ),
          if (widget.icon != null) ...[
            const SizedBox(width: 8), // Add some space between text and icon
            Icon(
              widget.icon!,
              color: const Color(0xffff9556),
            ),
          ]
        ],
      ),
    );
  }
}
