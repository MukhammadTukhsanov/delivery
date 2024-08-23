import 'package:flutter/material.dart';
import 'package:yolda/controllers/user_location.dart';

class HeaderLocation extends StatelessWidget {
  const HeaderLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        children: [
          const Icon(
            Icons.location_on_outlined,
            color: Colors.white,
            size: 24,
          ),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Transform.translate(
                offset: const Offset(0, 2),
                child: Text(
                  "${UserLocation.city}, ${UserLocation.street}",
                  style: const TextStyle(
                    fontFamily: 'Josefin Sans',
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -2),
                child: Text(
                  UserLocation.region,
                  style: const TextStyle(
                    fontFamily: 'Josefin Sans',
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
