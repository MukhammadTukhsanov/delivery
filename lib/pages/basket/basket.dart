import 'package:flutter/material.dart';
import 'package:yolda/global/global.dart';
import 'package:yolda/pages/basket/basket_item.dart';
import 'package:yolda/pages/order/index.dart';

class Basket extends StatefulWidget {
  final List<dynamic> basketData;
  final deliveryPrice;
  const Basket(
      {super.key, required this.basketData, required this.deliveryPrice});

  @override
  State<Basket> createState() => _BasketState();
}

class _BasketState extends State<Basket> {
  String _sumOfbasket = '';

  @override
  void initState() {
    super.initState();
    print(widget.deliveryPrice);
    _sum();
  }

  void _changeItemCount(int index, bool increment) {
    setState(() {
      if (increment) {
        widget.basketData[index]['count']++;
      } else if (widget.basketData[index]['count'] > 1) {
        widget.basketData[index]['count']--;
      }
    });
    _sum();
  }

  void _sum() {
    double totalSum = widget.basketData.fold(0, (sum, e) {
      String priceString = e["item"]["price"].toString().replaceAll(" ", '');
      double price = double.tryParse(priceString) ?? 0;
      double priceToCount = price * e["count"];
      return sum + priceToCount;
    });

    setState(() {
      _sumOfbasket = formatNumber(totalSum);
    });
  }

  void _removeItemFromBasket(index) {
    setState(() {
      widget.basketData[index]['count'] = 0;
    });
    _sum();
  }

  void emptybasket() {
    print("empty");
    setState(() {
      widget.basketData.forEach((e) {
        e['count'] = 0;
      });
    });
    _sum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff3f4f6),
        appBar: AppBar(
          backgroundColor: const Color(0xfff3f4f6),
          elevation: 0,
          title: const Text('Savat',
              style: TextStyle(
                  color: Color(0xff3c486b), fontFamily: 'Josefin Sans')),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(
                  context, widget.basketData); // Return updated basketData
            },
          ),
          actions: [
            GestureDetector(
              onTap: () => emptybasket(),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.delete_outlined),
              ),
            )
          ],
        ),
        body: _sumOfbasket == "0"
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 100,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Sizning savatingiz bo\'sh!',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: ListView.builder(
                      itemCount: widget.basketData.length,
                      itemBuilder: (context, index) {
                        var item = widget.basketData[index];
                        return item['count'] > 0
                            ? basketItem(
                                count: item["count"],
                                buildCount: _buildCountButton(
                                    icon: Icons.add,
                                    onTap: () => _changeItemCount(index, true)),
                                price: item['item']['price'],
                                unitOfMeasure: item['item']['unit-of-measure'],
                                measurementValue: item['item']
                                    ['measurement-value'],
                                name: item['item']['name'],
                                photo: item['item']['photo'],
                                removeItem: () => _removeItemFromBasket(index),
                                removeCount: _buildCountButton(
                                    icon: Icons.remove,
                                    onTap: () =>
                                        _changeItemCount(index, false)),
                              )
                            : SizedBox();
                      },
                    ),
                  )),
                  AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      height: _sumOfbasket == '0' ? 0 : 180,
                      child: SingleChildScrollView(
                        child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                    top: BorderSide(
                                        color: const Color(0xff3c486b)
                                            .withOpacity(.3),
                                        width: 2))),
                            width: MediaQuery.sizeOf(context).width,
                            height: 180,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Jami",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "Josefin Sans",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                      color: const Color(0xff3c486b)
                                          .withOpacity(.6)),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      _sumOfbasket,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: "Josefin Sans",
                                          fontWeight: FontWeight.w700,
                                          fontSize: 26,
                                          color: Color(0xff3c486b)
                                              .withOpacity(.9)),
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
                                const SizedBox(height: 8),
                                GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Order(
                                          deliveryPrice: widget.deliveryPrice,
                                          basketData: widget.basketData,
                                          basketItemsPrice: _sumOfbasket),
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
                ],
              ));
  }

  Widget _buildCountButton(
      {required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 25,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(2)),
        child: Center(
          child: Icon(icon, color: const Color(0xff3c486b), size: 18),
        ),
      ),
    );
  }
}
