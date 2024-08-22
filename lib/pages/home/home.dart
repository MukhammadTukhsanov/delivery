import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart';
import 'package:yolda/controllers/location_helper.dart';
import 'package:yolda/controllers/user_location.dart';
import 'package:yolda/widgets/textField/text_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;

  List headerMenu = [
    {'text': 'Chegirmalar', 'img': 'assets/img/discount.png'},
    {'text': 'Chegirmalar', 'img': 'assets/img/discount.png'},
    {'text': 'Chegirmalar', 'img': 'assets/img/discount.png'},
    {'text': 'Chegirmalar', 'img': 'assets/img/discount.png'}
  ];

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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: Colors.white,
                          size: 24,
                        ),
                        const SizedBox(width: 6),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Transform.translate(
                              offset: const Offset(0, 2),
                              child: Text(
                                "${UserLocation.city}, ${UserLocation.street}",
                                style: const TextStyle(
                                  fontFamily: 'Josefin Sans',
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Transform.translate(
                              offset: const Offset(0, -2),
                              child: Text(
                                UserLocation.region,
                                style: const TextStyle(
                                  fontFamily: 'Josefin Sans',
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
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
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            children: [],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
