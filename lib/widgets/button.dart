import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;

  Button({super.key, required this.text, required this.onPressed, this.icon});

  @override
  _Button createState() => _Button();
}

class _Button extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
      onPressed: widget.onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.text,
            style: const TextStyle(
              fontFamily: 'Josefin Sans',
              fontWeight: FontWeight.w700,
              color: Color(0xffFF9556),
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
