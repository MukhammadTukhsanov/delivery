import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChoiceChipWidget extends StatelessWidget {
  final Key? key;
  final String label;
  final bool isSelected;
  final VoidCallback onSelected;

  const ChoiceChipWidget({
    this.key, // Add this line
    required this.label,
    required this.isSelected,
    required this.onSelected,
  }) : super(key: key); // Pass the key to the super constructor

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

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Key?>('key', key));
    properties.add(DiagnosticsProperty<Key?>('key', key));
  }
}
