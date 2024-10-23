import 'dart:math';

import 'package:flutter/material.dart';
import 'package:yolda/controllers/user_location.dart';
import 'package:yolda/global/global.dart';

class Order extends StatefulWidget {
  final List basketData;
  final deliveryPrice;
  final basketItemsPrice;
  const Order(
      {super.key,
      required this.basketData,
      required this.deliveryPrice,
      required this.basketItemsPrice});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  final TextEditingController _adressController = TextEditingController(
      text: "${UserLocation.street}, ${UserLocation.place}");
  @override
  void initState() {
    super.initState();
    print("basket data: ${widget.basketData}");
    print(widget.deliveryPrice);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffffffff),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0), // Height of the AppBar
          child: AppBar(
            backgroundColor: const Color(0xffffffff),
            elevation: 0, // Remove shadow if you want a flat border
            title: const Text(
              'Buyurtma berish',
              style: TextStyle(
                color: Color(0xff3c486b),
                fontFamily: 'Josefin Sans',
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(.5), // Height of the border
              child: Container(
                color: const Color(0xff3c486b).withOpacity(.5), // Border color
                height: 1.0, // Thickness of the border
              ),
            ),
          ),
        ),
        body: Column(children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Disabled TextField
                  TextField(
                    controller: _adressController,
                    enabled: false,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 14),
                      filled: true,
                      fillColor: const Color(0xff3c486b)
                          .withOpacity(0.05), // Background color when disabled
                      disabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(12), // Border radius
                        borderSide: BorderSide(
                          color: const Color(0xff3c486b)
                              .withOpacity(0.2), // Border color with opacity
                          width: 1.5, // Border width
                        ),
                      ),
                      // labelText: 'Adress',
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Enabled TextField
                  // TextField(
                  //   enabled: true,
                  //   decoration: InputDecoration(
                  //     contentPadding: EdgeInsets.symmetric(horizontal: 14),
                  //     filled: true,
                  //     fillColor: Colors.white, // Background color when enabled
                  //     enabledBorder: OutlineInputBorder(
                  //       borderRadius:
                  //           BorderRadius.circular(12), // Border radius
                  //       borderSide: BorderSide(
                  //         color: const Color(0xff3c486b)
                  //             .withOpacity(0.5), // Border color with opacity
                  //         width: 1.5, // Border width
                  //       ),
                  //     ),
                  //     focusedBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(6),
                  //       borderSide: const BorderSide(
                  //         color: Color(0xff3c486b), // Border color when focused
                  //         width: 1.5,
                  //       ),
                  //     ),
                  //     labelText: 'Enabled TextField',
                  //   ),
                  // ),
                  Text(
                    "To'lov tizimini tanlang",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontFamily: "Josefin Sans",
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff3c486b).withOpacity(.7)),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                color: Color(0xff3c486b).withOpacity(0.2))),
                        child: const Image(
                          height: 40,
                          image: AssetImage('assets/img/logoClick.png'),
                        ),
                      )),
                      SizedBox(width: 12),
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                color: Color(0xff3c486b).withOpacity(0.2))),
                        child: const Image(
                          height: 40,
                          image: AssetImage('assets/img/logoPayme.png'),
                        ),
                      )),
                      SizedBox(width: 12),
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                color: Color(0xff3c486b).withOpacity(0.2))),
                        child: const Image(
                          height: 36,
                          image: AssetImage('assets/img/logoApelsin.png'),
                        ),
                      )),
                    ],
                  ),
                  SizedBox(height: 24),
                  Text(
                    "Maxsulotlar ro'yxati",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontFamily: "Josefin Sans",
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff3c486b).withOpacity(.7)),
                  ),
                  Column(
                    children: [
                      ...widget.basketData.asMap().entries.map((entrie) {
                        var e = entrie.value;
                        int index = entrie.key;
                        return DottedLineText(
                          key: ValueKey(index),
                          leftText:
                              "${e['item']['name']} * ${e["count"]} ${e["item"]["unit-of-measure"]}",
                          rightText: formatNumber(e["count"] *
                              double.parse(
                                  "${e["item"]["price"]}".replaceAll(" ", ""))),
                        );
                      })
                    ],
                  )
                ],
              ),
            ),
          ),
          AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              height: "_sumOfbasket" == '0' ? 0 : 180,
              child: SingleChildScrollView(
                child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            top: BorderSide(
                                color: const Color(0xff3c486b).withOpacity(.3),
                                width: 2))),
                    width: MediaQuery.sizeOf(context).width,
                    height: 180,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Yetkazib berish:",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "Josefin Sans",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                    color: const Color(0xff3c486b)
                                        .withOpacity(.6)),
                              ),
                              Text(
                                "${widget.deliveryPrice == 0 ? 'Tekin' : formatNumber(widget.deliveryPrice)}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "Josefin Sans",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                    color: const Color(0xff3c486b)
                                        .withOpacity(.6)),
                              ),
                            ]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Umumiy summa:",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "Josefin Sans",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: Color(0xff3c486b)),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  formatNumber(double.parse(widget
                                          .basketItemsPrice
                                          .toString()
                                          .replaceAll(" ", "")) +
                                      widget.deliveryPrice),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "Josefin Sans",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 26,
                                      color: Color(0xff3c486b).withOpacity(.9)),
                                ),
                                Text(
                                  " UZS",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "Josefin Sans",
                                      fontWeight: FontWeight.w900,
                                      fontSize: 14,
                                      color: const Color(0xff3c486b)
                                          .withOpacity(.6)),
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Order(
                                  deliveryPrice: widget.deliveryPrice,
                                  basketData: widget.basketData,
                                  basketItemsPrice: widget.basketItemsPrice),
                            ),
                          ),
                          child: Container(
                            width: MediaQuery.sizeOf(context).width,
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color(0xffff9556),
                            ),
                            child: const Text(
                              "Buyurtma berish",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Josefin Sans',
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
              ))
        ]));
  }
}

class DottedLineText extends StatelessWidget {
  final String leftText;
  final String rightText;
  final ValueKey? key;

  const DottedLineText(
      {required this.leftText, required this.rightText, this.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        key: key,
        children: [
          // Left text with flexible width
          Text(
            leftText,
            overflow: TextOverflow.ellipsis, // Ellipsis to prevent overflow
            style: const TextStyle(
                fontFamily: "Josefin Sans",
                fontWeight: FontWeight.w600,
                color: Color(0xff3c486b),
                fontSize: 18),
          ),
          const SizedBox(
              width: 10), // Optional space between left text and dots

          // Dots section
          Flexible(
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Calculate number of dots based on available width
                int dotCount = (constraints.maxWidth / 8)
                    .floor(); // Estimate 8px per dot including padding
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Center dots
                  children: List.generate(
                    dotCount,
                    (index) => const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.0),
                      child: Text(
                        '.',
                        style: TextStyle(color: Color(0xff3c486b)),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(
              width: 10), // Optional space between dots and right text

          // Right text with flexible width
          Text(
            rightText,
            overflow: TextOverflow.ellipsis, // Ellipsis to prevent overflow
            style: const TextStyle(
                fontFamily: "Josefin Sans",
                fontWeight: FontWeight.w600,
                color: Color(0xff3c486b),
                fontSize: 18),
          ),
        ],
      ),
    );
  }
}
