import 'package:flutter/material.dart';

class KitchenMenuItems extends StatefulWidget {
  String foodName;
  String foodPrice;
  Map<String, dynamic> ingredients;
  String imageURL;
  int productCount;
  int index;
  Function(int) onCountChanged;
  KitchenMenuItems(
      {super.key,
      required this.foodName,
      required this.foodPrice,
      required this.ingredients,
      required this.imageURL,
      required this.productCount,
      required this.onCountChanged,
      required this.index});

  @override
  _KitchenMenuItemsState createState() => _KitchenMenuItemsState();
}

class _KitchenMenuItemsState extends State<KitchenMenuItems> {
  String ingredientsText = '';
  @override
  void initState() {
    setState(() {
      ingredientsText = '${widget.ingredients.values.join(', ')}, ';
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Padding kitchenMenuItems(
    //   {required int key,
    //   required String foodName,
    //   required String foodPrice,
    //   required String imageURL,
    //   required int index,
    //   required Map<String, dynamic> ingredients,
    //   required int productId}) {
    // setState(() {
    //   ingredientsText = '${ingredients.values.join(', ')}, ';
    // });

    // int productCount = productCountMap[productId] ?? 0;
    return Padding(
      key: ValueKey(widget.index),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
            border: Border.all(
                width: 1, color: const Color(0xff3c486b).withOpacity(.3)),
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.foodName,
                      style: const TextStyle(
                          fontFamily: 'Josefin Sans',
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff3c486b))),
                  Text(widget.foodPrice,
                      style: TextStyle(
                          fontFamily: 'Josefin Sans',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff3c486b).withOpacity(.8))),
                  Text(
                    ingredientsText.substring(0, ingredientsText.length - 2),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 18,
                        color: const Color(0xff3c486b).withOpacity(.8),
                        fontFamily: 'Josefin Sans',
                        letterSpacing: 2),
                  )
                ],
              ),
            ),
            Container(
                width: 110,
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1,
                        color: const Color(0xff3c486b).withOpacity(0.4)),
                    borderRadius: BorderRadius.circular(12)),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(widget.imageURL),
                    ),
                    Positioned(
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
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 00),
                                transitionBuilder: (Widget child,
                                    Animation<double> animation) {
                                  final inAnimation = Tween<Offset>(
                                    begin: const Offset(
                                        1.0, 0.0), // Starts from the right
                                    end: Offset.zero,
                                  ).animate(animation);

                                  final outAnimation = Tween<Offset>(
                                    begin: Offset.zero,
                                    end: const Offset(
                                        -1.0, 0.0), // Exits to the left
                                  ).animate(animation);

                                  return child.key == const ValueKey<int>(1)
                                      ? SlideTransition(
                                          position: inAnimation, child: child)
                                      : SlideTransition(
                                          position: outAnimation, child: child);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    widget.productCount != 0
                                        ? GestureDetector(
                                            onTap: () {
                                              if (widget.productCount > 0) {
                                                widget.onCountChanged(
                                                    widget.productCount - 1);
                                              }
                                            },
                                            child: SizedBox(
                                              width: 18,
                                              height: 18,
                                              child: Image.asset(
                                                  'assets/img/trash.png',
                                                  width: 18,
                                                  height: 18,
                                                  scale: 1),
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
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          )
                                        : const SizedBox(),
                                    GestureDetector(
                                      onTap: () {
                                        widget.onCountChanged(
                                            widget.productCount + 1);
                                        print("plus");
                                      },
                                      child: SizedBox(
                                        child: Image.asset(
                                          'assets/img/plus.png',
                                          scale: 1,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
