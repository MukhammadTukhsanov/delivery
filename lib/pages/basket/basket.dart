import 'package:flutter/material.dart';

class Basket extends StatefulWidget {
  const Basket({super.key});

  @override
  State<Basket> createState() => _BasketState();
}

class _BasketState extends State<Basket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff3f4f6),
        appBar: AppBar(
          backgroundColor: const Color(0xfff3f4f6),
          elevation: 0,
          title: const Text(
            'Savat',
            style:
                TextStyle(color: Color(0xff3c486b), fontFamily: 'Josefin Sans'),
          ),
          centerTitle: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(),
                                image: const DecorationImage(
                                    image:
                                        AssetImage('assets/img/fanta.png')))),
                        const Text(
                          'Fanta',
                          style: TextStyle(
                              fontFamily: 'Josefin Sans',
                              fontSize: 18,
                              color: Color(0xff3c486b),
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
