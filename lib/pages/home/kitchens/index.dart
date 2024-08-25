import 'package:flutter/material.dart';
import 'package:yolda/controllers/gets.dart';
import 'package:yolda/pages/home/list_title.dart';
import 'package:yolda/pages/home/market_item.dart';

class Kitchens extends StatefulWidget {
  const Kitchens({super.key});

  @override
  _KitchensState createState() => _KitchensState();
}

class _KitchensState extends State<Kitchens> {
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
      return await Gets.kitchens();
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

        final kitchensData = snapshot.data!;

        return Column(
          children: [
            const Divider(),
            ListTitle(
              text: "Oshxonalar",
            ),
            ...kitchensData.map((e) {
              return MarketItem(
                afterFree: e['after-free'],
                deliveryPrice: e['delivery-price'],
                maxDeliveryTime: e['max-delivery-time'],
                minDeliveryTime: e['min-delivery-time'],
                minOrder: e['min-order'],
                name: e['name'],
                photo: e['imageUrl'],
              );
            }).toList(),
          ],
        );
      },
    );
  }
}
