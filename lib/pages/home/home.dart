import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart';
import 'package:yolda/controllers/location_helper.dart';
import 'package:yolda/controllers/user_location.dart';
import 'package:yolda/pages/home/header_location.dart';
import 'package:yolda/pages/home/header_menu.dart';
import 'package:yolda/pages/home/item_card.dart';
import 'package:yolda/pages/home/list_title.dart';
import 'package:yolda/widgets/textField/text_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = false;
    });
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
            : Column(
                children: [
                  const HeaderLocation(),
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
                        const SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: EdgeInsets.only(left: 16.0, top: 6),
                            child: Row(
                              children: [
                                ItemCard(),
                                ItemCard(),
                                ItemCard(),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Divider(),
                        ListTitle(
                          text: "Oshxonalar",
                        ),
                        const SizedBox(height: 20)
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
