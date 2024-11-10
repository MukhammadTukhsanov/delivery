import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:yolda/controllers/gets.dart';
import 'package:yolda/controllers/user_location.dart';
import 'package:yolda/global/global.dart';
import 'package:yolda/pages/basket/basket.dart';
import 'package:yolda/pages/market/kitchen/kitchen-menu-items.dart';
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

      // Add an "index" to each item
      for (int i = 0; i < fetchedData.length; i++) {
        fetchedData[i]["index"] = i;
      }
      setState(() {
        data = fetchedData;
      });
      print("data: $data");
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
          Expanded(
              child: Column(
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                        Text("kamida - ${widget.minOrder} So'm",
                            style: _textStyle),
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
                            Text("${widget.deliveryPrice} So'm",
                                style: _textStyle),
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
                            photo: item['photo']!,
                            text: item['text']!,
                            key: index);
                      })
                    ],
                  ),
                )
              else
                Expanded(
                    child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    var item = data[
                        index]; // Accessing the item directly with the index
                    return KitchenMenuItems(
                      index: item['index'],
                      foodName: item['name'],
                      foodPrice: item['price'],
                      imageURL: item['imageUrl'],
                      ingredients: item['ingredients'] ?? {},
                      productCount: productCounts[item['index']] ?? 0,
                      onCountChanged: (newCount) {
                        updateProductCount(
                          item['index'],
                          newCount,
                          double.parse('${item['price']}'.replaceAll(' ', '')),
                          item,
                        );
                      },
                    );
                  },
                ))

              // menuItems()
            ],
          )),
          AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              height: totalAmountIsShowed ? 180 : 0,
              child: SingleChildScrollView(
                child: _showTotalAmount(),
              )),
        ],
      )),
    );
  }

  void updateProductCounts() {
    // Create a list to store items that need to be removed
    List<dynamic> itemsToRemove = [];

    for (var basketItem in basketItems) {
      // Check if the count is zero
      if (basketItem["count"] == 0) {
        itemsToRemove.add(basketItem);
      } else {
        // Update the productCounts for items with non-zero counts
        setState(() {
          productCounts[basketItem["item"]["index"]] = basketItem["count"];
        });
      }
    }

    // Remove the items with zero counts after the loop
    setState(() {
      for (var item in itemsToRemove) {
        basketItems.remove(item);
        productCounts.remove(item["item"]["index"]);
      }
    });
    // Recalculate the total price based on product counts
    totalPrice = productCounts.entries.fold(0.0, (sum, entry) {
      return sum +
          entry.value *
              double.parse('${data[entry.key]['price']}'.replaceAll(' ', ''));
    });

    //   // Recalculate the total number of items in the basket
    basketProductNumber =
        productCounts.values.fold(0, (sum, value) => value + sum);

    // Show totalAmount only if there are products in the basket
    totalAmountIsShowed = basketProductNumber > 0;
  }

  void updateProductCount(int index, int count, double price, item) {
    var searchItem = basketItems.indexWhere((element) {
      return element['item'] == item;
    });

    setState(() {
      if (searchItem != -1) {
        // Update the count of the existing item
        basketItems[searchItem]["count"] = count;
      } else {
        // Add new item to the basket
        basketItems.add({"count": count, "item": item});
      }
    });

    // Update the product counts after updating basketItems
    updateProductCounts();
  }

  List basketItems = [];
  Map productCounts = {};
  double totalPrice = 0.0;
  int basketProductNumber = 0;
  bool totalAmountIsShowed = false;

  Container _showTotalAmount() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              top: BorderSide(
                  color: const Color(0xff3c486b).withOpacity(.3), width: 2))),
      width: MediaQuery.sizeOf(context).width,
      height: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          double.parse(widget.afterFree.replaceAll(' ', '')) - totalPrice <= 0
              ? Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Image.asset('assets/img/check.png', width: 22),
                  const SizedBox(width: 6),
                  const Text(
                    'Sizga bepul yetkazib beriladi',
                    style: TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontWeight: FontWeight.w700,
                      color: Color(0xff35a952),
                      fontSize: 15,
                    ),
                  )
                ])
              : Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Image.asset('assets/img/discount.png', width: 22),
                  const SizedBox(width: 6),
                  Text(
                    '${formatNumber(double.parse(widget.afterFree.replaceAll(' ', '')) - totalPrice)} So\'mdan keyin bepul yetkazib beriladi',
                    style: const TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontWeight: FontWeight.w700,
                      color: Color(0xff3c486b),
                      fontSize: 15,
                    ),
                  )
                ]),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            borderRadius: BorderRadius.circular(10),
            value: double.parse(widget.afterFree.replaceAll(' ', '')) == 0
                ? 1
                : (totalPrice *
                        100 /
                        double.parse(widget.afterFree.replaceAll(' ', ''))) /
                    100,
            color: double.parse(widget.afterFree.replaceAll(' ', '')) -
                        totalPrice <=
                    0
                ? const Color(0xff35a952)
                : const Color(0xffff9556),
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: () async {
              final updatedBasket = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Basket(
                      basketData: basketItems,
                      deliveryPrice: totalPrice >=
                              double.parse(widget.afterFree.replaceAll(' ', ''))
                          ? 0
                          : double.parse(widget.afterFree.replaceAll(' ', ''))),
                ),
              );

              // Check if updatedBasket is not null and update the state
              if (updatedBasket != null) {
                setState(() {
                  basketItems =
                      updatedBasket; // Update basketItems with the returned data
                });
                updateProductCounts();
              }
            },
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xffff9556),
              ),
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      width: 24,
                      height: 24,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '$basketProductNumber',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xffffffff),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Josefin Sans',
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        'Savatingizni ko\'ring',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Josefin Sans',
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: Text(
                        '${formatNumber(totalPrice)} So\'m',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Josefin Sans',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
