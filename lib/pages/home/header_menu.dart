import 'package:flutter/material.dart';

class HeaderMenu extends StatefulWidget {
  const HeaderMenu({super.key});

  @override
  State<HeaderMenu> createState() => _HeaderMenuState();
}

class _HeaderMenuState extends State<HeaderMenu> {
  List headerMenu = [
    {'text': 'Chegirmalar', 'img': 'assets/img/discount.png'},
    {'text': 'Savdo', 'img': 'assets/img/markets.png'},
    {'text': 'Kuponlarim', 'img': 'assets/img/coupons.png'},
    {'text': 'Kel ol', 'img': 'assets/img/yourself.png'}
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...headerMenu.asMap().entries.map((entry) {
            int index = entry.key;
            var e = entry.value;
            return GestureDetector(
              onTap: () {},
              child: Column(
                children: [
                  Image.asset(
                    e['img'],
                    width: 64,
                    height: 64,
                  ),
                  Text(
                    e['text'],
                    style: TextStyle(
                        fontFamily: 'Josefin Sans',
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff3c486b).withOpacity(.9),
                        fontSize: 16),
                  )
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}
