import 'package:flutter/material.dart';
import 'package:spendo/screen/color&theme.dart';
import 'package:spendo/screen/common_component/ListCard.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      child: Column(
        children: [
          SizedBox(height: height * 0.04),
          Text(
            'Monday',
            style: TextStyle(
              fontSize: width * 0.06,
              fontWeight: FontWeight.bold,
              color: AppColors.color1,
            ),
          ),
          Container(
            margin: EdgeInsets.all(width * 0.04),
            padding: EdgeInsets.all(width * 0.04),
            width: width * 0.9,
            decoration: BoxDecoration(
              color: AppColors.color1,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Remaining Balance',
                      style: TextStyle(
                        fontSize: width * 0.03,
                        color: AppColors.color5,
                      ),
                    ),
                    Text(
                      'Rs 5,000',
                      style: TextStyle(
                        fontSize: width * 0.05,
                        fontWeight: FontWeight.bold,
                        color: AppColors.color5,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: width * 0.4,
                      //color: AppColors.color3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Income : 10,000/=',
                            style: TextStyle(
                              fontSize: width * 0.03,
                              color: AppColors.color5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Out come : 10,000/=',
                            style: TextStyle(
                              fontSize: width * 0.03,
                              fontWeight: FontWeight.bold,
                              color: AppColors.color5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: width * 0.4,
                      //color: AppColors.color5,
                      child: const Icon(
                        Icons.bar_chart,
                        color: AppColors.color5,
                        size: 32,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.02),
          Container(
            width: width * 0.85,
            child: Text(
              'Today : 2025 March 10',
              style: TextStyle(
                fontSize: width * 0.03,
                fontWeight: FontWeight.bold,
                color: AppColors.color1,
              ),
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
