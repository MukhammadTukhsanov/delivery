import 'package:flutter/material.dart';
import 'package:yolda/controllers/user_location.dart';
import 'package:yolda/pages/home/list_title.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List headerMenu = [
    {'text': 'Savdo', 'img': 'assets/img/markets.png'},
    {'text': 'Suv', 'img': 'assets/img/water.png'},
    {'text': 'Go`sht', 'img': 'assets/img/meat.png'},
    {'text': 'Ovqatlar', 'img': 'assets/img/food.png'}
  ];

  void _navigateToScreen(String text) {
    switch (text) {
      case 'Chegirmalar':
        () {};
        break;
      case 'Savdo':
        break;
      case 'Kuponlarim':
        () {};
        break;
      case 'Kel ol':
        () {};
        break;
      default:
        // Handle unknown menu item
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(2.0),
              child: Container(
                  color: const Color(0xff3c486b).withOpacity(.4), height: 1.0)),
          title: ListTile(
              title: Text("${UserLocation.city}, ${UserLocation.street}",
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontFamily: 'Josefin Sans',
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff3C486B).withOpacity(.9),
                    fontSize: 18,
                  )),
              subtitle: Text(UserLocation.region,
                  style: TextStyle(
                    fontFamily: 'Josefin Sans',
                    color: const Color(0xff3C486B).withOpacity(.9),
                    fontSize: 15,
                  ))),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...headerMenu.asMap().entries.map((entry) {
                    int index = entry.key;
                    var e = entry.value;
                    return GestureDetector(
                      key: ValueKey(index),
                      onTap: () => _navigateToScreen(e['text']),
                      child: Column(
                        children: [
                          Image.asset(
                            e['img'],
                            width: 64,
                            height: 64,
                          ),
                          Text(
                            e['text'],
                            style: TextStyle(
                                fontFamily: 'Josefin Sans',
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff3c486b).withOpacity(.9),
                                fontSize: 16),
                          )
                        ],
                      ),
                    );
                  })
                ],
              ),
            ),
            Divider(),
            ListTitle(
              text: 'Mashxur do`konlar',
            )
          ],
        ));
  }
}
