import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yolda/controllers/gets.dart';
import 'package:yolda/controllers/user_location.dart';
import 'package:yolda/pages/market/market-products.dart/products.dart';

class KitchenPage extends StatefulWidget {
  String photo;
  String name;
  String minOrder;
  String minDeliveryTime;
  String maxDeliveryTime;
  String deliveryPrice;
  String afterFree;
  String filter;
  String kitchenName;
  KitchenPage(
      {super.key,
      required this.afterFree,
      required this.deliveryPrice,
      required this.maxDeliveryTime,
      required this.minDeliveryTime,
      required this.minOrder,
      required this.name,
      required this.photo,
      required this.filter,
      required this.kitchenName});

  @override
  State<KitchenPage> createState() => _KitchenPageState();
}

class _KitchenPageState extends State<KitchenPage> {
  String ingredientsText = '';
  List<Map<String, dynamic>> data = [];
  Map<int, int> productCountMap = {};
  @override
  void initState() {
    super.initState();
    _fetchMenuData();
  }

  Future<void> _fetchMenuData() async {
    try {
      List<Map<String, dynamic>> fetchedData = await Gets.getMenu(
          kitchen: widget.kitchenName, filter: widget.filter);
      setState(() {
        data = fetchedData;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  // Method to set the product count for a specific product ID
  void setProductCount(int id, int count) {
    setState(() {
      productCountMap[id] = count;
    });
  }

  var meniItems = [
    {'text': 'Barchasi', 'photo': 'markets.png'},
    {'text': 'Meva va sabzavotlar', 'photo': 'fruitsAndVeggies.png'},
    {'text': 'Ichimliklar', 'photo': 'drinks.png'},
    {'text': 'Go\'sht mahsulotlari', 'photo': 'meat-products.png'},
    {'text': 'Sut & nonushta', 'photo': 'milk & breakefast.png'},
    {'text': 'Asosiy oziq-ovqat', 'photo': 'cooking-oils.png'},
    {'text': 'Non mahsulotlari', 'photo': 'bread.png'},
    {'text': 'Tozalik', 'photo': 'cleaning.png'},
    {'text': 'Muzqaymoq', 'photo': 'icecream.png'},
    {'text': 'Choy va Qahva', 'photo': 'cofee&tea.png'},
    {'text': 'Shaxsiy gigiyena', 'photo': 'hygiene.png'},
    {
      'text': 'Bir martali ishlatiladigan mahsulotlar',
      'photo': 'toilet-paper.png'
    },
    {'text': 'Boshqalar', 'photo': 'vector.png'}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: ListTile(
            title: Text("${UserLocation.street}, ${UserLocation.place}",
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontFamily: 'Josefin Sans',
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff3C486B).withOpacity(.9),
                  fontSize: 18,
                )),
            subtitle: Text(
                "${UserLocation.locality}, ${UserLocation.region
                // .substring(0, UserLocation.region.length - 7)
                }",
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
          if (widget.filter == 'markets')
            Expanded(
              child: GridView.count(
                addAutomaticKeepAlives: true,
                addRepaintBoundaries: true,
                addSemanticIndexes: true,
                childAspectRatio: 3 / 3.3,
                shrinkWrap: true,
                crossAxisSpacing: 2,
                mainAxisSpacing: 4,
                crossAxisCount: 4,
                children: [
                  ...meniItems.asMap().entries.map((e) {
                    var item = e.value;
                    int index = e.key;
                    return marketMenuItems(
                        photo: item['photo']!, text: item['text']!, key: index);
                  })
                ],
              ),
            )
          else
            ...data.asMap().entries.map((e) {
              var item = e.value;
              int index = e.key;
              return kitchenMenuItems(
                  key: index,
                  foodName: item['name'],
                  foodPrice: item['price'],
                  imageURL: item['imageUrl'],
                  ingredients: item['ingredients'] ?? {},
                  productId: index);
            })
          // menuItems()
        ],
      )),
    );
  }

  Padding kitchenMenuItems(
      {required int key,
      required String foodName,
      required String foodPrice,
      required String imageURL,
      required Map<String, dynamic> ingredients,
      required int productId}) {
    setState(() {
      ingredientsText = '${ingredients.values.join(', ')}, ';
    });
    int productCount = productCountMap[productId] ?? 0;
    return Padding(
      key: ValueKey(key),
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
                      child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xff3c486b).withOpacity(.4),
                                blurRadius: 4,
                                spreadRadius: 1,
                                blurStyle: BlurStyle.outer,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(50),
                          ),
                          height: 30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    setProductCount(productId,
                                        (productCountMap[productId] ?? 0) - 1);
                                  },
                                  child: SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: Image.asset('assets/img/trash.png',
                                        width: 18, height: 18, scale: 1),
                                  )),
                              SizedBox(
                                width: 24,
                                height: 24,
                                child: Center(
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    '$productCount',
                                    overflow: TextOverflow.visible,
                                    style: const TextStyle(
                                        color: Color(0xff3c486b),
                                        fontFamily: 'Josefin Sans',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    setProductCount(productId,
                                        (productCountMap[productId] ?? 0) + 1);
                                  },
                                  child: SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: Image.asset('assets/img/plus.png',
                                        width: 18, height: 18, scale: 1),
                                  )),
                            ],
                          )),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  GestureDetector marketMenuItems(
      {required String photo, required String text, required int key}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MarketProducts(
                    market: widget.kitchenName,
                    minOrder: widget.minOrder,
                    activeMenu: text,
                    afterFree: widget.afterFree)));
      },
      child: Column(
        key: ValueKey(key),
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 65,
            width: 75,
            child: Center(
              child: Image.asset(
                'assets/img/$photo',
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            text,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: _textStyle,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  TextStyle get _textStyle => TextStyle(
        fontFamily: 'Josefin Sans',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: const Color(0xff3c486b).withOpacity(.5),
      );
}
