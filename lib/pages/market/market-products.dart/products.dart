import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yolda/controllers/gets.dart';

class MarketProducts extends StatefulWidget {
  String market;
  String minOrder;
  MarketProducts({super.key, required this.market, required this.minOrder});

  @override
  State<MarketProducts> createState() => _MarketProductsState();
}

class _MarketProductsState extends State<MarketProducts> {
  String _selectedChip = 'Barchasi';
  List data = [];
  Map<int, int> productCounts = {}; // Map to store product counts by index
  double totalPrice = 0.0;

  @override
  void initState() {
    Gets.getMarketProducts(market: widget.market).then((gets) {
      setState(() {
        data = gets;
      });
    });
    super.initState();
  }

  void updateProductCount(int index, int count, double price) {
    setState(() {
      // Update the product count
      productCounts[index] = count;

      // Recalculate the total price
      totalPrice = 0.0;
      productCounts.forEach((key, value) {
        totalPrice +=
            value * double.parse('${data[key]['price']}'.replaceAll(' ', ''));
      });
    });
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
            style: const TextStyle(color: Color(0xff3c486b)),
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
                child: Column(
                  children: [
                    GridView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      itemCount: data.length,
                      shrinkWrap:
                          true, // Important to make the GridView take only needed space
                      physics:
                          const NeverScrollableScrollPhysics(), // Disable GridView scrolling
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio:
                            0.76, // Adjust the aspect ratio to make items fit better
                      ),
                      itemBuilder: (context, index) {
                        var item = data[index];
                        return ProductItem(
                          item: item,
                          index: index,
                          productCount: productCounts[index] ?? 0,
                          onCountChanged: (newCount) {
                            updateProductCount(
                                index,
                                newCount,
                                double.parse(
                                    '${item['price']}'.replaceAll(' ', '')));
                            _showTotalAmount(
                                context); // Show modal with updated total
                          },
                        );
                      },
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              top: BorderSide(
                                  color: Color(0xff3c486b).withOpacity(.3),
                                  width: 2))),
                      width: MediaQuery.sizeOf(context).width,
                      height: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/img/discount.png',
                                  width: 22,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '${widget.minOrder} So\'mdan keyin bepul yekzip beriladi',
                                  style: const TextStyle(
                                      fontFamily: 'Josefin Sans',
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff3c486b),
                                      fontSize: 15),
                                )
                              ]),
                          const SizedBox(height: 16),
                          // Text(
                          //   'Total price: ${totalPrice.toStringAsFixed(2)} So\'m',
                          //   style: const TextStyle(
                          //     fontSize: 16,
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          // ),
                          const SizedBox(height: 8),
                          LinearProgressIndicator(
                            borderRadius: BorderRadius.circular(10),
                            value: .2,
                            color: Color.fromARGB(255, 237, 117, 47),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.orange,
                            ),
                            // onPressed: () {
                            //   // Button click action
                            //   print("Button Pressed");
                            // },
                            child: Stack(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 26,
                                  height: 26,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.white),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: const Text(
                                    '1',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xffffffff),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const Text(
                                  'Savatingizni ko\'ring',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Text(
                                  '10 000 So\'m',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            // ElevatedButton(
                            //   style: ButtonStyle(),
                            //   onPressed: () {
                            //     Navigator.pop(context); // Close modal
                            //   },
                            //   child: const Text('Close'),
                            // ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Padding headerMenu() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            ChoiceChipWidget(
              label: 'Barchasi',
              isSelected: _selectedChip == 'Barchasi',
              onSelected: () => _selectChip('Barchasi'),
            ),
            ChoiceChipWidget(
              label: 'Ko\'p sotilganlar',
              isSelected: _selectedChip == 'Ko\'p sotilganlar',
              onSelected: () => _selectChip('Ko\'p sotilganlar'),
            ),
            ChoiceChipWidget(
              label: 'Meva va sabzavotlar',
              isSelected: _selectedChip == 'Meva va sabzavotlar',
              onSelected: () => _selectChip('Meva va sabzavotlar'),
            ),
            ChoiceChipWidget(
              label: 'Ichimliklar',
              isSelected: _selectedChip == 'Ichimliklar',
              onSelected: () => _selectChip('Ichimliklar'),
            ),
            ChoiceChipWidget(
              label: 'Oqvatlar',
              isSelected: _selectedChip == 'Oqvatlar',
              onSelected: () => _selectChip('Oqvatlar'),
            ),
          ],
        ),
      ),
    );
  }

  void _showTotalAmount(BuildContext context) {
    Scaffold.of(context).showBottomSheet(
      enableDrag: false,
      (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  top: BorderSide(
                      color: Color(0xff3c486b).withOpacity(.3), width: 2))),
          width: MediaQuery.sizeOf(context).width,
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Total Amount',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Total price: ${totalPrice.toStringAsFixed(2)} So\'m',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close modal
                },
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _selectChip(String label) {
    setState(() {
      _selectedChip = label;
    });
  }
}

class ProductItem extends StatefulWidget {
  final dynamic item;
  final int index;
  final int productCount; // Current count of the product
  final Function(int) onCountChanged; // Callback to update count in the parent

  ProductItem({
    super.key,
    required this.item,
    required this.index,
    required this.productCount,
    required this.onCountChanged,
  });

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      key: ValueKey(widget.index),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          width: double.infinity,
          height: 160,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(widget.item['photo']),
              fit: BoxFit.contain,
            ),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color(0xff3c486b).withOpacity(.2),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                right: 6,
                bottom: 6,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xff3c486b).withOpacity(.4),
                        blurRadius: 4,
                        spreadRadius: 1,
                        blurStyle: BlurStyle.outer,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(50),
                  ),
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      widget.productCount != 0
                          ? GestureDetector(
                              onTap: () {
                                if (widget.productCount > 0) {
                                  widget
                                      .onCountChanged(widget.productCount - 1);
                                }
                              },
                              child: Image.asset('assets/img/trash.png',
                                  width: 18, height: 18, scale: 1))
                          : const SizedBox(),
                      widget.productCount != 0
                          ? SizedBox(
                              width: 24,
                              height: 24,
                              child: Center(
                                child: Text(
                                  textAlign: TextAlign.center,
                                  '${widget.productCount}',
                                  overflow: TextOverflow.visible,
                                  style: const TextStyle(
                                      color: Color(0xff3c486b),
                                      fontFamily: 'Josefin Sans',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          : SizedBox(),
                      GestureDetector(
                        onTap: () {
                          widget.onCountChanged(widget.productCount + 1);
                        },
                        child: Image.asset('assets/img/plus.png',
                            scale: 1, width: 18, height: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${widget.item['price']} So\'m',
          style: const TextStyle(
            fontFamily: 'Josefin Sans',
            color: Color(0xff3c486b),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        LayoutBuilder(
          builder: (context, constraints) {
            return Text.rich(
              TextSpan(
                text: '${widget.item['name']}',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xff3c486b).withOpacity(.7),
                ),
                children: [
                  TextSpan(
                    text:
                        ' ${widget.item['measurement-value']} ${widget.item['unit-of-measure']}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis, // Add ellipsis for longer texts
            );
          },
        ),
      ],
    );
  }
}

class ChoiceChipWidget extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onSelected;

  ChoiceChipWidget({
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ChoiceChip(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
        showCheckmark: false,
        label: Text(label),
        selected: isSelected,
        onSelected: (bool selected) {
          onSelected();
        },
        selectedColor: const Color(0xff3C486B),
        backgroundColor: Colors.white,
        labelStyle: TextStyle(
            color: isSelected ? Colors.white : const Color(0xff3c486b),
            fontFamily: 'Josefin Sans',
            fontSize: 14),
        shape: StadiumBorder(
          side: BorderSide(
            color: const Color(0xff3c486b).withOpacity(0.3),
          ),
        ),
      ),
    );
  }
}
