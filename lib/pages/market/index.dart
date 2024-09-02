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
  String kitchenName;
  MarketPage(
      {super.key,
      required this.afterFree,
      required this.deliveryPrice,
      required this.maxDeliveryTime,
      required this.minDeliveryTime,
      required this.minOrder,
      required this.name,
      required this.photo,
      required this.kitchenName});

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  String ingredientsText = '';

  Map<String, String> ingredients = {
    '0': 'un',
    '1': "go'sht",
  };
  List<Map<String, dynamic>> data = [];
  @override
  void initState() {
    super.initState();
    _fetchMenuData();
  }

  Future<void> _fetchMenuData() async {
    try {
      List<Map<String, dynamic>> fetchedData =
          await Gets.getMenu(kitchen: widget.kitchenName);
      setState(() {
        data = fetchedData;
      });
      print('Data: $data');
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
          ...data.asMap().entries.map((e) {
            var item = e.value;
            int index = e.key;
            return menuItems(
                foodName: item['name'],
                foodPrice: item['price'],
                imageURL: item['imageUrl'],
                ingredients: item['ingredients']);
          })
          // menuItems()
        ],
      )),
    );
  }

  Padding menuItems(
      {required String foodName,
      required String foodPrice,
      required String imageURL,
      required Map<String, dynamic> ingredients}) {
    setState(() {
      ingredientsText = ingredients.values.join(', ') + ', ';
    });
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
            border: Border.all(
                width: 1, color: const Color(0xff3c486b).withOpacity(.3)),
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(foodName,
                      style: const TextStyle(
                          fontFamily: 'Josefin Sans',
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff3c486b))),
                  Text(foodPrice,
                      style: TextStyle(
                          fontFamily: 'Josefin Sans',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff3c486b).withOpacity(.8))),
                  Text(
                    ingredientsText.substring(0, ingredientsText.length - 2),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 18,
                        color: const Color(0xff3c486b).withOpacity(.8),
                        fontFamily: 'Josefin Sans',
                        letterSpacing: 2),
                  )
                ],
              ),
            ),
            Container(
                width: 110,
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1,
                        color: const Color(0xff3c486b).withOpacity(0.4)),
                    borderRadius: BorderRadius.circular(12)),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(imageURL),
                    ),
                    Positioned(
                      right: 6,
                      bottom: 6,
                      child: GestureDetector(
                        child: Container(
                            width: 30,
                            height: 30,
                            padding: EdgeInsets.all(7),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xff3c486b).withOpacity(.5),
                                      spreadRadius: 1,
                                      blurRadius: 7,
                                      offset: Offset(0, 0))
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: Image.asset('assets/img/plus.png'),
                            )),
                      ),
                    ),
                  ],
                ))
          ],
        ),
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
