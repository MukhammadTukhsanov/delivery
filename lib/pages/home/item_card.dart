import 'package:flutter/material.dart';
import 'package:yolda/controllers/gets.dart';
import 'package:yolda/pages/home/home.dart';
import 'package:yolda/pages/market/index.dart';

class ItemCard extends StatefulWidget {
  int? maxItems;
  String? orders;
  String scrollDirection;
  ItemCard(
      {super.key, required this.scrollDirection, this.orders, this.maxItems});

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  late Future<List<Map<String, dynamic>>> _kitchensFuture;

  @override
  void initState() {
    super.initState();
    _loadKitchens();
  }

  void _loadKitchens() {
    setState(() {
      _kitchensFuture = _fetchKitchens();
    });
  }

  Future<List<Map<String, dynamic>>> _fetchKitchens() async {
    try {
      if (widget.orders == 'lastOrders') {
        return Gets.getLastOrders();
      } else {
        return await Gets.kitchens();
      }
    } catch (e) {
      print('Error fetching kitchens: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
        future: _kitchensFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No kitchens available'));
          }

          List<Map<String, dynamic>> kitchensData = snapshot.data!;
          if (kitchensData.isNotEmpty &&
              kitchensData.length > 3 &&
              widget.maxItems != null) {
            kitchensData = kitchensData.sublist(0, 3);
          }
          return SingleChildScrollView(
            scrollDirection: widget.scrollDirection == 'horizontal'
                ? Axis.horizontal
                : Axis.vertical,
            child: Padding(
              padding: EdgeInsets.only(
                  left: 16.0,
                  top: 8,
                  right: widget.scrollDirection == 'horizontal' ? 0 : 16),
              child: widget.scrollDirection == 'horizontal'
                  ? Row(
                      children: [
                        ...kitchensData.map((e) {
                          return item(
                              scrollDirection: 'horizontal',
                              afterFree: e['after-free'],
                              deliveryPrice: e['delivery-price'],
                              maxDeliveryTime: e['max-delivery-time'],
                              minDeliveryTime: e['min-delivery-time'],
                              minOrder: e['min-order'],
                              name: e['name'],
                              photo: e['imageUrl'],
                              kitchenName: e['kitchenName']);
                        })
                      ],
                    )
                  : Column(
                      children: [
                        ...kitchensData.map((e) {
                          return item(
                              scrollDirection: 'vertical',
                              afterFree: e['after-free'],
                              deliveryPrice: e['delivery-price'],
                              maxDeliveryTime: e['max-delivery-time'],
                              minDeliveryTime: e['min-delivery-time'],
                              minOrder: e['min-order'],
                              name: e['name'],
                              photo: e['imageUrl'],
                              kitchenName: e['kitchenName'].toString());
                        }),
                        Container(
                          child: TextButton(
                            child: Text(
                                'Barchasini ko`rsatish ${snapshot.data!.length - widget.maxItems!}'),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
            ),
          );
        });
  }

  GestureDetector item(
      {String? scrollDirection,
      required String photo,
      required String name,
      required String minOrder,
      required String minDeliveryTime,
      required String maxDeliveryTime,
      required String deliveryPrice,
      required String afterFree,
      required String kitchenName}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MarketPage(
                    photo: photo,
                    name: name,
                    minOrder: minOrder,
                    minDeliveryTime: minDeliveryTime,
                    maxDeliveryTime: maxDeliveryTime,
                    deliveryPrice: deliveryPrice,
                    afterFree: afterFree,
                    kitchenName: kitchenName)));
      },
      child: Container(
        margin: EdgeInsets.only(
            bottom: scrollDirection == 'horizontal' ? 0 : 16,
            right: scrollDirection == 'horizontal' ? 16 : 0),
        width: widget.scrollDirection == 'horizontal'
            ? 300
            : MediaQuery.sizeOf(context).width,
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
                  child: Image.network(
                    photo,
                    width: double.infinity,
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
                      Text(
                        name,
                        style: const TextStyle(
                          fontFamily: 'Josefin Sans',
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff3c486b),
                        ),
                      ),
                      // Row(
                      //   children: [
                      //     Transform.translate(
                      //       offset: const Offset(0, -3),
                      //       child: Image.asset(
                      //         'assets/img/star.png',
                      //         width: 16,
                      //         height: 16,
                      //       ),
                      //     ),
                      //     const SizedBox(width: 8),
                      //     const Text(
                      //       "4.0",
                      //       style: TextStyle(
                      //         fontFamily: 'Josefin Sans',
                      //         fontSize: 18,
                      //         fontWeight: FontWeight.w700,
                      //         color: Color(0xff3c486b),
                      //       ),
                      //     ),
                      //     const SizedBox(width: 8),
                      //     Text(
                      //       "(100+)",
                      //       style: TextStyle(
                      //         fontFamily: 'Josefin Sans',
                      //         fontSize: 18,
                      //         fontWeight: FontWeight.w700,
                      //         color: Color(0xff3c486b).withOpacity(.5),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("kamida - $minOrder So'm", style: _textStyle),
                    ],
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/img/clock.png', width: 16),
                          const SizedBox(width: 6),
                          Text("$minDeliveryTime-$maxDeliveryTime min",
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
                          Text("$deliveryPrice So'm", style: _textStyle),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  widget.scrollDirection != 'horizontal'
                      ? Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          width: double.infinity,
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
                                  "Tekin yetkazib berish $afterFree so'm dan yuqori buyurtmada",
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
                      : const SizedBox()
                ],
              ),
            ),
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
