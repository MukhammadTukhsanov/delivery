import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart';
import 'package:yolda/controllers/auth_service.dart';
import 'package:yolda/controllers/gets.dart';
import 'package:yolda/controllers/location_helper.dart';
import 'package:yolda/controllers/user_location.dart';
import 'package:yolda/pages/home/header_location.dart';
import 'package:yolda/pages/home/header_menu.dart';
import 'package:yolda/pages/home/item_card.dart';
import 'package:yolda/pages/home/kitchens/index.dart';
import 'package:yolda/pages/home/list_title.dart';
import 'package:yolda/pages/home/market_item.dart';
import 'package:yolda/widgets/textField/text_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;
  List kitchensData = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = false;
    });
    Gets.getLastOrders();
    getUserLocation().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF9556),
      body: SafeArea(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    GestureDetector(
                        onDoubleTap: () {
                          AuthService.logout();
                        },
                        child: const HeaderLocation()),
                    const SizedBox(height: 16),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Input(
                        inputType: 'search',
                        placeholder: 'Ovqatlar, Mahsulotlar',
                        fillColor: Color(0xffffffff),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          const HeaderMenu(),
                          const Divider(),
                          ListTitle(
                            text: "Oldingi buyurtmalaringiz",
                            onTap: () {},
                          ),
                          ItemCard(scrollDirection: 'horizontal'),
                          // const SingleChildScrollView(
                          //   scrollDirection: Axis.horizontal,
                          //   child: Padding(
                          //     padding: EdgeInsets.only(left: 16.0, top: 6),
                          //     child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       children: [
                          //         ItemCard(),
                          //         ItemCard(),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          const Divider(),
                          ListTitle(text: "Oshxonalar"),
                          ItemCard(scrollDirection: 'vertical'),
                          const SizedBox(height: 8),
                          // Kitchens(),
                          const SizedBox(height: 20)
                        ],
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
