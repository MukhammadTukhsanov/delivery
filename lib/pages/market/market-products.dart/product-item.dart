import 'package:flutter/material.dart';

class ProductItem extends StatefulWidget {
  final dynamic item;
  final int index;
  final int productCount; // Current count of the product
  final Function(int) onCountChanged; // Callback to update count in the parent

  const ProductItem({
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
                  padding: const EdgeInsets.symmetric(horizontal: 6),
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
                              child: SizedBox(
                                width: 18,
                                height: 18,
                                child: Image.asset('assets/img/trash.png',
                                    width: 18, height: 18, scale: 1),
                              ))
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
                          : const SizedBox(),
                      GestureDetector(
                        onTap: () {
                          widget.onCountChanged(widget.productCount + 1);
                        },
                        child: SizedBox(
                          width: 18,
                          height: 18,
                          child: Image.asset('assets/img/plus.png',
                              scale: 1, width: 18, height: 18),
                        ),
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
                  color: const Color(0xff3c486b).withOpacity(.7),
                ),
                children: [
                  TextSpan(
                    text:
                        ' ${widget.item['measurement-value']} ${widget.item['unit-of-measure']}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
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
