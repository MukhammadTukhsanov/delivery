import 'package:flutter/material.dart';

class basketItem extends StatefulWidget {
  final Function() removeItem;
  String photo;
  String name;
  String measurementValue;
  String unitOfMeasure;
  String price;
  Widget removeCount;
  Widget buildCount;
  int count;
  basketItem(
      {super.key,
      required this.removeItem,
      required this.photo,
      required this.name,
      required this.measurementValue,
      required this.unitOfMeasure,
      required this.price,
      required this.removeCount,
      required this.buildCount,
      required this.count});

  @override
  State<basketItem> createState() => _basketItemState();
}

class _basketItemState extends State<basketItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            Positioned(
                right: -16,
                top: -16,
                child: IconButton(
                  onPressed: widget.removeItem,
                  icon: const Icon(
                    Icons.close,
                    size: 22,
                    color: Color(0xff3c486b),
                  ),
                )),
            Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                        color: const Color(0xff3c486b).withOpacity(.21)),
                    image: DecorationImage(image: NetworkImage(widget.photo)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: const TextStyle(
                            fontFamily: 'Josefin Sans',
                            color: Color(0xff3c486b),
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${widget.measurementValue} ${widget.unitOfMeasure} - ${widget.price} So\'m',
                        style: const TextStyle(
                            color: Color(0xff3c486b),
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xff3c486b).withOpacity(.05),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color:
                                      const Color(0xff3c486b).withOpacity(.1)),
                            ),
                            child: Row(
                              children: [
                                widget.removeCount,
                                // _buildCountButton(
                                //     icon: Icons.remove,
                                //     onTap: () =>
                                //         _changeItemCount(index, false)),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text('${widget.count}',
                                      style: const TextStyle(
                                          color: Color(0xff3c486b),
                                          fontWeight: FontWeight.bold)),
                                ),
                                widget.buildCount
                                // _buildCountButton(
                                //     icon: Icons.add,
                                //     onTap: () => _changeItemCount(index, true)),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                  "${formatWithSpaces(widget.count * double.parse('${widget.price}'.replaceAll(' ', '')))}",
                                  style: TextStyle(
                                      color: Color(0xff3c486b),
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18)),
                              Text(
                                " UZS",
                                style: TextStyle(
                                    color: Color(0xff3c486b).withOpacity(.5),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  String formatWithSpaces(double value) {
    String result =
        value.toStringAsFixed(0); // Convert to string without decimal part
    result = result.replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match match) {
      return '${match[1]} ';
    });
    return result.trim(); // Remove any trailing spaces
  }
}
