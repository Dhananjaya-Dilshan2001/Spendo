import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:spendo/screen/color&theme.dart';
import 'package:spendo/screen/common_component/buttons.dart';
import 'package:spendo/screen/common_component/category_card.dart';
import 'package:spendo/screen/common_component/plan_card.dart';

class PlanPage extends StatelessWidget {
  const PlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: height * 0.01),

        children: [
          SizedBox(height: height * 0.01),
          Center(
            child: Text(
              'Monthly Spending Planning',
              style: TextStyle(
                fontSize: width * 0.05,
                fontWeight: FontWeight.bold,
                color: AppColors.color1,
              ),
            ),
          ),
          Container(
            height: height * 0.25,
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
            child: BarChart(
              BarChartData(
                baselineY: height * 0.1,
                //alignment: BarChartAlignment.spaceBetween,
                maxY: 8,
                minY: 0,
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  show: false, // Hide axis titles for a clean look
                ),
                borderData: FlBorderData(
                  show: false, // Hide border
                ),
                gridData: FlGridData(show: false), // Hide grid
                barGroups: [
                  BarChartGroupData(
                    x: 0,
                    barRods: [
                      BarChartRodData(
                        toY: 7,
                        color: AppColors.color1, // blue-violet
                        width: 30,
                        borderRadius: BorderRadius.zero,
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 1,
                    barRods: [
                      BarChartRodData(
                        toY: 5,
                        color: Color(0xFF2EC4B6), // teal
                        width: 30,
                        borderRadius: BorderRadius.zero,
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 2,
                    barRods: [
                      BarChartRodData(
                        toY: 3.5,
                        color: Color(0xFFFF6F61), // coral
                        width: 30,
                        borderRadius: BorderRadius.zero,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: height * 0.02),
          PlanCard(color: AppColors.color1),
          PlanCard(color: AppColors.color2),
          PlanCard(color: AppColors.color3),
          SizedBox(height: height * 0.04),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'My Categories',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: width * 0.05,
                  color: AppColors.color1,
                ),
              ),
              Mybutton1(label: 'Add New'),
            ],
          ),
          SizedBox(height: height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: width * 0.4,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [CategoryCard(color: AppColors.color3)],
                ),
              ),
              Container(
                width: width * 0.4,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [CategoryCard(color: AppColors.color2)],
                ),
              ),
            ],
          ),
          SizedBox(height: height * 0.02),
        ],
      ),
    );
  }
}
