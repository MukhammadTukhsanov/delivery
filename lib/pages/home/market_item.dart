import 'package:flutter/material.dart';

class MarketItem extends StatelessWidget {
  final String name;
  final String photo;
  final String minOrder;
  final String minDeliveryTime;
  final String maxDeliveryTime;
  final String deliveryPrice;
  final String afterFree;

  const MarketItem({
    super.key,
    required this.name,
    required this.photo,
    required this.minOrder,
    required this.minDeliveryTime,
    required this.maxDeliveryTime,
    required this.deliveryPrice,
    required this.afterFree,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white, // Placeholder color for missing images
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: photo.isNotEmpty
                  ? Image.network(
                      photo,
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.error,
                            color: Color(
                                0xff3c486b)); // Display an error icon if the image fails to load
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    )
                  : const Center(
                      child:
                          CircularProgressIndicator()), // Placeholder while loading
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff3c486b),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "kamida - $minOrder So'm",
                    style: _textStyle,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/img/clock.png', width: 16),
                          const SizedBox(width: 6),
                          Text(
                            "$minDeliveryTime-$maxDeliveryTime min",
                            style: _textStyle,
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Color(0xff3c486b).withOpacity(.7),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Row(
                        children: [
                          Image.asset('assets/img/delivery.png', width: 16),
                          const SizedBox(width: 6),
                          Text(
                            "$deliveryPrice So'm",
                            style: _textStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xff3c486b).withOpacity(.1),
                      border: Border.all(
                        width: 1,
                        color: const Color(0xff3c486b).withOpacity(.5),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/img/discount.png',
                          width: 20,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            "Tekin yetkazib berish $afterFree so'm dan yuqori buyurtmada",
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xff3c486b),
                              fontFamily: 'Josefin Sans',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
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

  TextStyle get _textStyle => TextStyle(
        fontFamily: 'Josefin Sans',
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: const Color(0xff3c486b).withOpacity(.5),
      );
}
