import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:yolda/controllers/gets.dart';
import 'package:yolda/pages/basket/basket.dart';
import 'package:yolda/pages/market/market-products.dart/choice-chip.dart';
import 'package:yolda/pages/market/market-products.dart/product-item.dart';

class MarketProducts extends StatefulWidget {
  String activeMenu;
  String market;
  String minOrder;
  String afterFree;
  MarketProducts(
      {super.key,
      required this.market,
      required this.minOrder,
      required this.activeMenu,
      required this.afterFree});

  @override
  State<MarketProducts> createState() => _MarketProductsState();
}

class _MarketProductsState extends State<MarketProducts> {
  List data = [];
  List<dynamic> filteredData = [];
  Map<int, int> productCounts = {}; // Map to store product counts by index
  double totalPrice = 0.0;
  int basketProductNumber = 0;
  bool totalAmountIsShowed = false;

  String _selectedChip = '';
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _chipKeys = [];

  @override
  void initState() {
    super.initState();
    _selectedChip = widget.activeMenu;
    // Initialize GlobalKeys for each menu item
    meniItems.forEach((item) {
      _chipKeys.add(GlobalKey());
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedChip();
    });

    Gets.getMarketProducts(market: widget.market).then((gets) {
      setState(() {
        data = gets;
        filter(widget.activeMenu); // Call filter here directly
      });
    });
  }

  filter(String type) {
    setState(() {
      if (type == 'Barchasi') {
        filteredData = data;
      } else {
        filteredData = data.where((product) {
          return product['type'].toString().toLowerCase() == type.toLowerCase();
        }).toList();
      }
    });
  }

  void _scrollToSelectedChip() {
    int selectedIndex =
        meniItems.indexWhere((item) => item['text'] == _selectedChip);

    if (selectedIndex != -1 && _scrollController.hasClients) {
      // Get the context of the selected chip using the GlobalKey
      RenderBox? renderBox = _chipKeys[selectedIndex]
          .currentContext
          ?.findRenderObject() as RenderBox?;

      if (renderBox != null) {
        // Get the position of the selected chip relative to the scrollable area
        double position = renderBox
            .localToGlobal(Offset.zero, ancestor: context.findRenderObject())
            .dx;

        // Scroll to the calculated position
        _scrollController.animateTo(
          position,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  void updateProductCount(int index, int count, double price) {
    if (count < 0) return; // Prevent negative counts

    setState(() {
      if (count == 0) {
        productCounts.remove(index); // Remove the product if the count is zero
      } else {
        productCounts[index] = count; // Update the count
      }

      // Recalculate the total price based on product counts
      totalPrice = productCounts.entries.fold(0.0, (sum, entry) {
        return sum +
            entry.value *
                double.parse('${data[entry.key]['price']}'.replaceAll(' ', ''));
      });

      // Recalculate the total number of items in the basket
      basketProductNumber =
          productCounts.values.fold(0, (sum, value) => sum + value);

      // Show totalAmount only if there are products in the basket
      totalAmountIsShowed = basketProductNumber > 0;
    });
  }

  var meniItems = [
    {'text': 'Barchasi', 'photo': 'markets.png'},
    {'text': 'Meva va sabzavotlar', 'photo': 'fruitsAndVeggies.png'},
    {'text': 'Ichimliklar', 'photo': 'drinks.png'},
    {'text': 'Go\'sht mahsulotlari', 'photo': 'meat-products.png'},
    {'text': 'Sut & nonushta', 'photo': 'milk & breakefast.png'},
    {'text': 'Asosiy oziq-ovqat', 'photo': 'cooking-oils.png'},
    {'text': 'Non mahsulotlari', 'photo': 'bread.png'},
    {'text': 'Tozalik', 'photo': 'cleaning.png'},
    {'text': 'Muzqaymoq', 'photo': 'icecream.png'},
    {'text': 'Choy va Qahva', 'photo': 'cofee&tea.png'},
    {'text': 'Shaxsiy gigiyena', 'photo': 'hygiene.png'},
    {
      'text': 'Bir martali ishlatiladigan mahsulotlar',
      'photo': 'toilet-paper.png'
    },
    {'text': 'Boshqalar', 'photo': 'vector.png'}
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          _selectedChip,
          style: const TextStyle(
              color: Color(0xff3c486b), fontFamily: 'Josefin Sans'),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          headerMenu(),
          const Divider(height: 1),
          Expanded(
              // Use Expanded to take the remaining screen height
              child: SingleChildScrollView(
                  // Allow the entire page to scroll
                  child: Column(children: [
            GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: filteredData.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.76,
              ),
              itemBuilder: (context, index) {
                var item = filteredData[index];
                return ProductItem(
                  key: ValueKey(index),
                  item: item,
                  index: index,
                  productCount: productCounts[index] ?? 0,
                  onCountChanged: (newCount) {
                    updateProductCount(index, newCount,
                        double.parse('${item['price']}'.replaceAll(' ', '')));
                  },
                );
              },
              cacheExtent: 200, // Improves scrolling performance
            )
          ]))),
          AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              height: totalAmountIsShowed ? 180 : 0,
              child: SingleChildScrollView(
                child: _showTotalAmount(),
              )),
        ],
      ),
    );
  }

  String formatNumber(double number) {
    // Convert to string without decimal places
    String numberString = number.toStringAsFixed(0);
    StringBuffer result = StringBuffer();
    int count = 0;

    // Loop through the string in reverse
    for (int i = numberString.length - 1; i >= 0; i--) {
      count++;
      result.write(numberString[i]);
      // Add a space every 3 digits
      if (count % 3 == 0 && i != 0) {
        result.write(' ');
      }
    }

    // Reverse the result to get the correct format
    return result.toString().split('').reversed.join('');
  }

  SingleChildScrollView headerMenu() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: _scrollController, // Add this line
      child: Row(
        children: <Widget>[
          const SizedBox(width: 8),
          ...meniItems.asMap().entries.map((entry) {
            var e = entry.value;
            int index = entry.key;
            return ChoiceChipWidget(
              key: _chipKeys[index], // Assign a GlobalKey to each chip
              label: '${e['text']}',
              isSelected: _selectedChip == '${e['text']}',
              onSelected: () {
                filter(e['text']!);
                return _selectChip('${e['text']}');
              },
            );
          }),
        ],
      ),
    );
  }

  Container _showTotalAmount() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              top: BorderSide(
                  color: const Color(0xff3c486b).withOpacity(.3), width: 2))),
      width: MediaQuery.sizeOf(context).width,
      height: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          double.parse(widget.afterFree.replaceAll(' ', '')) - totalPrice <= 0
              ? Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Image.asset('assets/img/check.png', width: 22),
                  const SizedBox(width: 6),
                  const Text(
                    'Sizga bepul yetkazib beriladi',
                    style: TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontWeight: FontWeight.w700,
                      color: Color(0xff35a952),
                      fontSize: 15,
                    ),
                  )
                ])
              : Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Image.asset('assets/img/discount.png', width: 22),
                  const SizedBox(width: 6),
                  Text(
                    '${formatNumber(double.parse(widget.afterFree.replaceAll(' ', '')) - totalPrice)} So\'mdan keyin bepul yetkazib beriladi',
                    style: const TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontWeight: FontWeight.w700,
                      color: Color(0xff3c486b),
                      fontSize: 15,
                    ),
                  )
                ]),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            borderRadius: BorderRadius.circular(10),
            value: (totalPrice *
                    100 /
                    double.parse(widget.afterFree.replaceAll(' ', ''))) /
                100,
            color: double.parse(widget.afterFree.replaceAll(' ', '')) -
                        totalPrice <=
                    0
                ? const Color(0xff35a952)
                : const Color(0xffff9556),
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Basket()));
            },
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xffff9556),
              ),
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      width: 24,
                      height: 24,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '$basketProductNumber',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xffffffff),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Josefin Sans',
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        'Savatingizni ko\'ring',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Josefin Sans',
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: Text(
                        '${formatNumber(totalPrice)} So\'m',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Josefin Sans',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _selectChip(String label) {
    setState(() {
      _selectedChip = label;
    });
  }
}
