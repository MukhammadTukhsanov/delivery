import 'package:flutter/material.dart';
import 'package:yolda/controllers/gets.dart';

class MarketProducts extends StatefulWidget {
  String market;
  MarketProducts({super.key, required this.market});

  @override
  State<MarketProducts> createState() => _MarketProductsState();
}

class _MarketProductsState extends State<MarketProducts> {
  String _selectedChip = 'Barchasi';
  List data = [];

  @override
  void initState() {
    Gets.getMarketProducts(market: widget.market).then((gets) {
      setState(() {
        data = gets;
      });
    });
    super.initState();
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
                        return ProductItem(item: item, index: index);
                      },
                    ),
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

  void _selectChip(String label) {
    setState(() {
      _selectedChip = label;
    });
  }
}

class ProductItem extends StatefulWidget {
  ProductItem({super.key, required this.item, required this.index});

  dynamic item;
  int index;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  int countOfProduct = 0;
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
                image: NetworkImage(widget.item['photo']), fit: BoxFit.contain),
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
                  padding: const EdgeInsets.all(7),
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
                  // width: 30,
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      countOfProduct != 0
                          ? Image.asset('assets/img/trash.png')
                          : SizedBox(),
                      countOfProduct != 0
                          ? Text(
                              '$countOfProduct',
                              overflow: TextOverflow.visible,
                              style: TextStyle(
                                  color: Color(0xff3c486b),
                                  fontSize: 18,
                                  fontFamily: 'Josefin Sans'),
                            )
                          : SizedBox(),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              countOfProduct++;
                            });
                          },
                          child: Image.asset('assets/img/plus.png')),
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
                text:
                    '${widget.item['name']}${widget.item['name']}${widget.item['name']}${widget.item['name']}${widget.item['name']}',
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
