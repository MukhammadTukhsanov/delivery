import 'package:flutter/material.dart';

class KitchenMenuItems extends StatefulWidget {
  String foodName;
  String foodPrice;
  Map<String, dynamic> ingredients;
  String photo;
  int productCount;
  int index;
  Function(int) onCountChanged;
  KitchenMenuItems(
      {super.key,
      required this.foodName,
      required this.foodPrice,
      required this.ingredients,
      required this.photo,
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  Text("1 porstsiya",
                      style: TextStyle(
                          fontFamily: 'Josefin Sans',
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xff3c486b).withOpacity(.8))),
                  Text("${widget.foodPrice} so'm",
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
                      child: Image.network(widget.photo),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(6),
                        height: 30,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xff3c486b).withOpacity(.4),
                                blurRadius: 4,
                                spreadRadius: 1,
                                blurStyle: BlurStyle.outer,
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          children: [
                            widget.productCount > 0
                                ? GestureDetector(
                                    onTap: () {
                                      widget.onCountChanged(
                                          widget.productCount - 1);
                                    },
                                    child: Image.asset(
                                      'assets/img/trash.png',
                                      scale: 1,
                                      width: 18,
                                      height: 18,
                                    ))
                                : const SizedBox(),
                            widget.productCount > 0
                                ? SizedBox(
                                    width: 24,
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      '${widget.productCount}',
                                      overflow: TextOverflow.visible,
                                      style: const TextStyle(
                                          color: Color(0xff3c486b),
                                          fontFamily: 'Josefin Sans',
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                : const SizedBox(),
                            GestureDetector(
                              onTap: () {
                                print("plus");
                                widget.onCountChanged(widget.productCount + 1);
                              },
                              child: Image.asset('assets/img/plus.png',
                                  scale: 1, width: 18, height: 18),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
