import 'package:flutter/material.dart';

class ListTitle extends StatefulWidget {
  String? text;
  VoidCallback? onTap;
  ListTitle({super.key, this.text, this.onTap});

  @override
  State<ListTitle> createState() => _ListTitleState();
}

class _ListTitleState extends State<ListTitle> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GestureDetector(
        onTap: widget.onTap ?? () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.text!,
              style: const TextStyle(
                  fontFamily: "Josefin Sans",
                  fontWeight: FontWeight.w700,
                  color: Color(0xff3c486b),
                  fontSize: 18),
            ),
            widget.onTap != null
                ? Image.asset('assets/img/arrow-circle.png', width: 22)
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
