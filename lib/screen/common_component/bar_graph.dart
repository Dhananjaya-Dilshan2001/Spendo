import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:spendo/screen/color&theme.dart';

class MyBarGraph extends StatelessWidget {
  final double balance;
  final double totalIncome;
  final double totalExpense;
  final double width;
  final double height;
  final List<Color> barColors;
  const MyBarGraph({
    super.key,
    required this.balance,
    required this.totalIncome,
    required this.totalExpense,
    required this.width,
    required this.height,
    this.barColors = const [
      AppColors.color1, // blue-violet
      AppColors.color2, // teal
      AppColors.color3,
    ],
  });

  @override
  Widget build(BuildContext context) {
    double maxValue = [
      balance,
      totalIncome,
      totalExpense,
    ].reduce((a, b) => a > b ? a : b);
    return Container(
      width: 200,
      height: 200,
      child: BarChart(
        BarChartData(
          maxY: maxValue,
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
                  toY: balance,
                  color: barColors[0], // blue-violet
                  width: width * 0.15,
                  borderRadius: BorderRadius.zero,
                ),
              ],
            ),
            BarChartGroupData(
              x: 1,
              barRods: [
                BarChartRodData(
                  toY: totalIncome,
                  color: barColors[1], // teal
                  width: width * 0.15,
                  borderRadius: BorderRadius.zero,
                ),
              ],
            ),
            BarChartGroupData(
              x: 2,
              barRods: [
                BarChartRodData(
                  toY: totalExpense,
                  color: barColors[2], // coral
                  width: width * 0.15,
                  borderRadius: BorderRadius.zero,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
