import 'package:flutter/material.dart';

class ItemRow extends StatelessWidget {
  const ItemRow({
    super.key,
    required this.title,
    required this.value,
    this.isBold = false,
    this.valueColor,
  });

  final String title;
  final String value;
  final bool isBold;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: isBold ? 16 : 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: isBold ? 16 : 14,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}