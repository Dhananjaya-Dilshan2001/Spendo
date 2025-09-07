import 'package:flutter/material.dart';
import 'package:spendo/screen/color&theme.dart';
import 'package:spendo/screen/common_component/ListCard.dart';
import 'package:spendo/screen/common_component/component.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      child: Column(
        children: [
          SizedBox(height: height * 0.01),
          Text(
            'Total Transaction History',
            style: TextStyle(
              fontSize: width * 0.03,
              fontWeight: FontWeight.bold,
              color: AppColors.color1,
            ),
          ),
          Container(
            margin: EdgeInsets.all(width * 0.04),
            padding: EdgeInsets.symmetric(
              vertical: width * 0.04,
              horizontal: width * 0.08,
            ),
            width: width * 0.9,
            decoration: BoxDecoration(
              color: AppColors.color5,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyWidget1(
                  title: "Budget",
                  amount: "Rs 5,000",
                  color: AppColors.color1,
                  amountFontSize: width * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyWidget1(
                      title: "Total Income",
                      amount: "Rs 10,000",
                      color: AppColors.color3,
                      amountFontSize: width * 0.03,
                    ),
                    MyWidget1(
                      title: "Total Outcome",
                      amount: "Rs 10,000",
                      color: AppColors.color2,
                      amountFontSize: width * 0.03,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.02),
          Container(
            width: width * 0.85,
            child: Row(
              children: [
                Text(
                  'Date : 2025 March 10',
                  style: TextStyle(
                    fontSize: width * 0.03,
                    fontWeight: FontWeight.bold,
                    color: AppColors.color1,
                  ),
                ),
                SizedBox(width: width * 0.02),
                IconButton(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.05,
                    vertical: width * 0.005,
                  ),
                  style: IconButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: AppColors.color1,
                  ),
                  onPressed: () {},
                  icon: Icon(
                    Icons.calendar_month,
                    size: width * 0.04,
                    color: AppColors.color6,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: height * 0.02),
          Expanded(
            child: Container(
              width: width * 0.9,
              //color:AppColors.color2, // Set the background color of the container
              child: ListView(
                children: [...List.generate(5, (index) => ListCard1())],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
