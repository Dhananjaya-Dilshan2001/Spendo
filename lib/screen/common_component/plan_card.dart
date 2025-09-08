import 'package:flutter/material.dart';
import 'package:spendo/screen/common_component/buttons.dart';
import 'package:spendo/screen/common_component/component.dart';

class PlanCard extends StatelessWidget {
  final Color color;
  final String title;
  final String amount;
  final VoidCallback? onPressed;
  const PlanCard({
    super.key,
    required this.color,
    required this.title,
    required this.amount,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyWidget1(
            title: title,
            amount: amount,
            color: color,
            amountFontSize: 24,
          ),

          Mybutton1(
            label: "Change",
            onPressed: () {
              onPressed?.call();
            },
          ),
        ],
      ),
    );
  }
}
