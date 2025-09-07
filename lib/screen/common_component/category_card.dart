import 'package:flutter/material.dart';
import 'package:spendo/screen/color&theme.dart';

class CategoryCard extends StatelessWidget {
  final Color color;
  const CategoryCard({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2),
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: width * 0.02,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          CircleAvatar(radius: width * 0.03, backgroundColor: AppColors.color1),
          SizedBox(width: 10),
          Text(
            'Shopping',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.color1,
            ),
          ),
        ],
      ),
    );
  }
}
