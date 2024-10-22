import 'package:flutter/material.dart';
import 'package:yolda/pages/home/home.dart';
import 'package:yolda/pages/profile/profie.dart'; // Ensure HomePage is imported

class TabBarSeparator extends StatefulWidget {
  const TabBarSeparator({super.key});

  @override
  State<TabBarSeparator> createState() => _TabBarSeparatorState();
}

class _TabBarSeparatorState extends State<TabBarSeparator>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this); // 3 tabs in total
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController, // Linking TabController to TabBarView
        children: const [
          HomePage(), // HomePage for Asosiy
          Center(child: Text('Category Screen')), // Placeholder for Kategoriya
          Center(child: Text('Orders Screen')), // Placeholder for Buyurtmalar
          ProfilePage(), // Placeholder for Buyurtmalar
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            border: BorderDirectional(
                top: BorderSide(color: Color(0xff3c486b).withOpacity(.5)))),
        child: Material(
          color: Colors
              .white, // Ensuring the Material background is also transparent
          child: TabBar(
            controller: _tabController, // Linking TabController
            tabs: const [
              Tab(
                icon: Icon(Icons.home_outlined),
                text: "Asosiy", // Home
              ),
              Tab(
                icon: Icon(Icons.auto_awesome_mosaic_outlined),
                text: "Kategoriya", // Category
              ),
              Tab(
                icon: Icon(Icons.shopping_bag_outlined),
                text: "Buyurtmalar", // Orders
              ),
              Tab(
                icon: Icon(Icons.person_outline_outlined),
                text: "Profile", // Orders
              ),
            ],
            labelStyle: const TextStyle(
                fontFamily: "Josefin Sans",
                color: Color(
                  0xff3c486b,
                ),
                fontSize: 12),
            labelColor: const Color(0xFFFF9556), // Active tab color
            unselectedLabelColor:
                Color(0xff3c486b).withOpacity(.7), // Inactive tab color
            indicatorColor: const Color(0xFFFF9556), // Indicator color
            // indicatorPadding: EdgeInsets.symmetric(
            //     horizontal: 1), // Optional for better alignment
          ),
        ),
      ),
    );
  }
}
