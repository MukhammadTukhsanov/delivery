import 'package:flutter/material.dart';
import 'package:yolda/controllers/gets.dart';
import 'package:yolda/pages/home/list_title.dart';
import 'package:yolda/pages/market/index.dart';

class ItemCard extends StatefulWidget {
  int? maxItems;
  final String? orders;
  final String scrollDirection;

  ItemCard({
    super.key,
    required this.scrollDirection,
    this.orders,
    this.maxItems,
  });

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  late Future<List<Map<String, dynamic>>> _kitchensFuture;
  bool isMoreShowed = false;

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
      return widget.orders == 'lastOrders'
          ? Gets.getLastOrders()
          : widget.orders == 'markets'
              ? await Gets.getMarkets()
              : await Gets.kitchens();
    } catch (e) {
      print('Error fetching kitchens: $e');
      return [];
    }
  }

  void _navigateToMarketPage(BuildContext context, Map<String, dynamic> data) {
    print('data: $data');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => KitchenPage(
          photo: data['imageUrl'],
          name: data['name'],
          minOrder: data['min-order'],
          minDeliveryTime: data['min-delivery-time'],
          maxDeliveryTime: data['max-delivery-time'],
          deliveryPrice: data['delivery-price'],
          afterFree: data['after-free'],
          filter: data['filter'],
          kitchenName: data['kitchenName'].toString(),
        ),
      ),
    );
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
          return const Center(child: Text('No kitchens available'));
        }

        List<Map<String, dynamic>> kitchensData = snapshot.data!;
        int maxItems = widget.maxItems ?? kitchensData.length;
        kitchensData = kitchensData.take(maxItems).toList();

        return SingleChildScrollView(
          scrollDirection: widget.scrollDirection == 'horizontal'
              ? Axis.horizontal
              : Axis.vertical,
          child: Padding(
              padding: EdgeInsets.only(
                left: 16.0,
                top: 8,
                right: widget.scrollDirection == 'horizontal' ? 0 : 16,
              ),
              child: widget.scrollDirection == 'horizontal'
                  ? Row(
                      children: kitchensData.map((e) {
                        return _buildItem(context, e);
                      }).toList(),
                    )
                  : Column(
                      children: [
                        ...kitchensData
                            .map((e) => _buildItem(context, e))
                            .toList(),
                        // if (snapshot.data!.length > widget.maxItems! &&
                        //     !isMoreShowed)
                        _buildShowMoreButton(context, snapshot.data!.length),
                      ],
                    )),
        );
      },
    );
  }

  GestureDetector _buildItem(BuildContext context, Map<String, dynamic> data) {
    return GestureDetector(
      onTap: () => _navigateToMarketPage(context, data),
      child: Container(
        margin: EdgeInsets.only(
          bottom: widget.scrollDirection == 'horizontal' ? 0 : 16,
          right: widget.scrollDirection == 'horizontal' ? 16 : 0,
        ),
        width: widget.scrollDirection == 'horizontal'
            ? 300
            : MediaQuery.of(context).size.width,
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
                    data['imageUrl'],
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
                ),
              ],
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['name'],
                    style: const TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff3c486b),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text("Kamida - ${data['min-order']} So'm", style: _textStyle),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Image.asset('assets/img/clock.png', width: 16),
                      const SizedBox(width: 6),
                      Text(
                        "${data['min-delivery-time']}-${data['max-delivery-time']} min",
                        style: _textStyle,
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Row(
                    children: [
                      Image.asset('assets/img/delivery.png', width: 16),
                      const SizedBox(width: 6),
                      Text("${data['delivery-price']} So'm", style: _textStyle),
                    ],
                  ),
                  if (widget.scrollDirection != 'horizontal')
                    Container(
                      margin: const EdgeInsets.only(top: 12, bottom: 12),
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
                              "Tekin yetkazib berish ${data['after-free']} So'm dan yuqori buyurtmada",
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
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShowMoreButton(BuildContext context, int itemsLength) {
    if (widget.maxItems == null ||
        widget.maxItems! > itemsLength ||
        isMoreShowed) {
      return const SizedBox();
    }

    return ListTitle(
      text: '+${itemsLength - widget.maxItems!} yana',
      onTap: () {
        setState(() {
          isMoreShowed = true;
          widget.maxItems = itemsLength;
        });
      },
    );
  }

  TextStyle get _textStyle => TextStyle(
        fontFamily: 'Josefin Sans',
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: const Color(0xff3c486b).withOpacity(.5),
      );
}
