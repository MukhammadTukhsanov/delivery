import 'package:flutter/material.dart';
import 'package:yolda/pages/basket/basket_item.dart';

class Basket extends StatefulWidget {
  final List<dynamic> backetData;
  const Basket({super.key, required this.backetData});

  @override
  State<Basket> createState() => _BasketState();
}

class _BasketState extends State<Basket> {
  void _changeItemCount(int index, bool increment) {
    setState(() {
      if (increment) {
        widget.backetData[index]['count']++;
      } else if (widget.backetData[index]['count'] > 1) {
        widget.backetData[index]['count']--;
      }
    });
  }

  void _removeItemFromBasket(index) {
    setState(() {
      widget.backetData[index]['count'] = 0;
      // widget.backetData.removeAt(index);
    });
    print(widget.backetData);
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
                context, widget.backetData); // Return updated backetData
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: widget.backetData.length,
          itemBuilder: (context, index) {
            var item = widget.backetData[index];
            return item['count'] > 0
                ? BacketItem(
                    count: item["count"],
                    buildCount: _buildCountButton(
                        icon: Icons.add,
                        onTap: () => _changeItemCount(index, true)),
                    price: item['item']['price'],
                    unitOfMeasure: item['item']['unit-of-measure'],
                    measurementValue: item['item']['measurement-value'],
                    name: item['item']['name'],
                    photo: item['item']['photo'],
                    removeItem: () => _removeItemFromBasket(index),
                    removeCount: _buildCountButton(
                        icon: Icons.remove,
                        onTap: () => _changeItemCount(index, false)),
                  )
                : SizedBox();
          },
        ),
      ),
    );
  }

  String formatWithSpaces(double value) {
    String result =
        value.toStringAsFixed(0); // Convert to string without decimal part
    result = result.replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match match) {
      return '${match[1]} ';
    });
    return result.trim(); // Remove any trailing spaces
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
