import 'package:flutter/material.dart';

class ItemCard extends StatefulWidget {
  const ItemCard({super.key});

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 1,
          color: const Color(0xff3c486b).withOpacity(.21),
        ),
      ),
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: Image.asset(
                  'assets/img/pizzad.png',
                  width: 300,
                  height: 160,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset('assets/img/heart.png'),
                ),
              )
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Domino's Pizza",
                      style: TextStyle(
                        fontFamily: 'Josefin Sans',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff3c486b),
                      ),
                    ),
                    Row(
                      children: [
                        Transform.translate(
                          offset: const Offset(0, -3),
                          child: Image.asset(
                            'assets/img/star.png',
                            width: 16,
                            height: 16,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          "4.0",
                          style: TextStyle(
                            fontFamily: 'Josefin Sans',
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff3c486b),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "(100+)",
                          style: TextStyle(
                            fontFamily: 'Josefin Sans',
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff3c486b).withOpacity(.5),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "kamida - ",
                      style: _textStyle,
                    ),
                    Text(
                      "50 000",
                      style: _textStyle,
                    ),
                    Text(
                      " So'm",
                      style: _textStyle,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/img/clock.png', width: 16),
                        const SizedBox(width: 6),
                        Text(
                          "12-25",
                          style: _textStyle,
                        ),
                        Text(
                          " min",
                          style: _textStyle,
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Color(0xff3c486b).withOpacity(.7),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Row(
                      children: [
                        Image.asset('assets/img/delivery.png', width: 16),
                        const SizedBox(width: 6),
                        Text(
                          "10 000",
                          style: _textStyle,
                        ),
                        Text(
                          " So'm",
                          style: _textStyle,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextStyle get _textStyle => TextStyle(
        fontFamily: 'Josefin Sans',
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: const Color(0xff3c486b).withOpacity(.5),
      );
}
