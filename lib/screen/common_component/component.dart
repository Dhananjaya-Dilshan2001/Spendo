import 'package:flutter/material.dart';

class MyWidget1 extends StatelessWidget {
  final String title;
  final String amount;
  final Color color;
  final double amountFontSize;
  const MyWidget1({
    super.key,
    required this.title,
    required this.amount,
    required this.color,
    required this.amountFontSize,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title, style: TextStyle(fontSize: width * 0.03, color: color)),
        Text(
          amount,
          style: TextStyle(
            fontSize: amountFontSize,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
