import 'package:flutter/material.dart';
import 'package:spendo/screen/color&theme.dart';

class ListCard1 extends StatefulWidget {
  const ListCard1({super.key});

  @override
  State<ListCard1> createState() => _ListCard1State();
}

class _ListCard1State extends State<ListCard1> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: height * 0.01,
        horizontal: width * 0.01,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.color5,
        boxShadow: [
          BoxShadow(
            color: AppColors.color4.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.03,
        vertical: height * 0.01,
      ),
      height: height * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(Icons.shopping_bag, color: AppColors.color1, size: width * 0.05),
          SizedBox(width: width * 0.03),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Shopping',
                style: TextStyle(
                  fontSize: width * 0.04,
                  fontWeight: FontWeight.bold,
                  color: AppColors.color1,
                ),
              ),
              Text(
                'Grocery and more',
                style: TextStyle(
                  fontSize: width * 0.03,
                  color: AppColors.color1,
                ),
              ),
            ],
          ),
          Spacer(),
          Text(
            '- 500 /=',
            style: TextStyle(
              fontSize: width * 0.04,
              fontWeight: FontWeight.bold,
              color: AppColors.color3,
            ),
          ),
        ],
      ),
    );
  }
}
