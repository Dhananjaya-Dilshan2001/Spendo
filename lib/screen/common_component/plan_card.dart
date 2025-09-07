import 'package:flutter/material.dart';
import 'package:spendo/screen/color&theme.dart';
import 'package:spendo/screen/common_component/buttons.dart';
import 'package:spendo/screen/common_component/component.dart';

class PlanCard extends StatelessWidget {
  final Color color;
  const PlanCard({super.key, required this.color});

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
            title: 'Monthly Budget',
            amount: '3000/=',
            color: AppColors.color1,
            amountFontSize: 24,
          ),
          MyWidget2(
            title: 'Same for Next Month',
            color: AppColors.color1,
            amountFontSize: 24,
          ),
          Mybutton1(label: "Change", onPressed: () {}),
        ],
      ),
    );
  }
}
