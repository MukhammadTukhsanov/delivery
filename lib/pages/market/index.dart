import 'package:flutter/material.dart';
import 'package:yolda/controllers/gets.dart';
import 'package:yolda/controllers/user_location.dart';

class MarketPage extends StatefulWidget {
  String photo;
  String name;
  String minOrder;
  String minDeliveryTime;
  String maxDeliveryTime;
  String deliveryPrice;
  String afterFree;
  MarketPage(
      {super.key,
      required this.afterFree,
      required this.deliveryPrice,
      required this.maxDeliveryTime,
      required this.minDeliveryTime,
      required this.minOrder,
      required this.name,
      required this.photo});

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  @override
  void initState() {
    Gets.getMenu(kitchen: "sharqona");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
            title: Text("${UserLocation.city}, ${UserLocation.street}",
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontFamily: 'Josefin Sans',
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff3C486B).withOpacity(.9),
                  fontSize: 18,
                )),
            subtitle: Text(UserLocation.region,
                style: TextStyle(
                  fontFamily: 'Josefin Sans',
                  color: const Color(0xff3C486B).withOpacity(.9),
                  fontSize: 15,
                ))),
      ),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Image.network(
              fit: BoxFit.cover,
              widget.photo,
              height: 160,
              width: double.infinity,
              excludeFromSemantics: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontFamily: 'Josefin Sans',
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff3c486b),
                  ),
                ),
                Row(
                  children: [
                    Text("kamida - ${widget.minOrder} So'm", style: _textStyle),
                  ],
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/img/clock.png', width: 16),
                        const SizedBox(width: 6),
                        Text(
                            "${widget.minDeliveryTime}-${widget.maxDeliveryTime} min",
                            style: _textStyle),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: const Color(0xff3c486b).withOpacity(.7),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Row(
                      children: [
                        Image.asset('assets/img/delivery.png', width: 16),
                        const SizedBox(width: 6),
                        Text("${widget.deliveryPrice} So'm", style: _textStyle),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Container(
                  width: MediaQuery.sizeOf(context).width,
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xff3c486b).withOpacity(.1),
                    border: Border.all(
                      width: 1,
                      color: const Color(0xff3c486b).withOpacity(.5),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/img/discount.png',
                        width: 20,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          "Tekin yetkazib berish ${widget.afterFree} so'm dan yuqori buyurtmada",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xff3c486b),
                            fontFamily: 'Josefin Sans',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const Divider(),
          Column(
            children: [],
          )
        ],
      )),
    );
  }

  TextStyle get _textStyle => TextStyle(
        fontFamily: 'Josefin Sans',
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: const Color(0xff3c486b).withOpacity(.5),
      );
}
