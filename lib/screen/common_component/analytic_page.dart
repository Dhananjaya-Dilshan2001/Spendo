import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:spendo/screen/color&theme.dart';
import 'package:spendo/screen/common_component/component.dart';
import 'package:spendo/screen/common_component/graph_card.dart';

class AnalyticPage extends StatelessWidget {
  const AnalyticPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      child: Column(
        children: [
          SizedBox(height: height * 0.01),
          Text(
            'Analytics',
            style: TextStyle(
              fontSize: width * 0.05,
              fontWeight: FontWeight.bold,
              color: AppColors.color1,
            ),
          ),
          SizedBox(height: height * 0.01),
          MyDropdownButton(items: ['September', 'Income', 'Expense']),
          SizedBox(height: height * 0.01),
          SizedBox(
            height: 200,
            child: BarChart(
              BarChartData(
                maxY: 10,
                minY: 0,
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                gridData: FlGridData(show: false),
                barGroups: [
                  BarChartGroupData(
                    x: 0,
                    barRods: [
                      BarChartRodData(
                        toY: 9,
                        color: Color(0xFF5A54D6),
                        width: 20,
                        borderRadius: BorderRadius.zero,
                      ),
                      BarChartRodData(
                        toY: 7,
                        color: Color(0xFF9B9BEB),
                        width: 20,
                        borderRadius: BorderRadius.zero,
                      ),
                    ],
                    barsSpace: 4,
                  ),
                  BarChartGroupData(
                    x: 1,
                    barRods: [
                      BarChartRodData(
                        toY: 7,
                        color: Color(0xFF2EC4B6),
                        width: 20,
                        borderRadius: BorderRadius.zero,
                      ),
                      BarChartRodData(
                        toY: 5,
                        color: Color(0xFF9DEAE1),
                        width: 20,
                        borderRadius: BorderRadius.zero,
                      ),
                    ],
                    barsSpace: 4,
                  ),
                  BarChartGroupData(
                    x: 2,
                    barRods: [
                      BarChartRodData(
                        toY: 4,
                        color: Color(0xFFFF6F61),
                        width: 20,
                        borderRadius: BorderRadius.zero,
                      ),
                      BarChartRodData(
                        toY: 6,
                        color: Color(0xFFFFB3AB),
                        width: 20,
                        borderRadius: BorderRadius.zero,
                      ),
                    ],
                    barsSpace: 4,
                  ),
                ],
                groupsSpace: 30,
              ),
            ),
          ),
          SizedBox(height: height * 0.02),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 24,
              runSpacing: 8,
              children: [
                _buildLegendItem(Color(0xFF5A54D6), 'Monthly budget', true),
                _buildLegendItem(Color(0xFF9B9BEB), 'Monthly budget', false),
                _buildLegendItem(Color(0xFF2EC4B6), 'Monthly income', true),
                _buildLegendItem(Color(0xFF9DEAE1), 'Monthly income', false),
                _buildLegendItem(Color(0xFFFF6F61), 'Monthly Expences', true),
                _buildLegendItem(Color(0xFFFFB3AB), 'Monthly Expences', false),
              ],
            ),
          ),
          SizedBox(height: height * 0.03),
          GraphCard(),
        ],
      ),
    );
  }
}

Widget _buildLegendItem(Color color, String text, bool bold) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(width: 16, height: 16, color: color),
      SizedBox(width: 6),
      Text(
        text,
        style: TextStyle(
          color: Color(0xFF5A54D6),
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          fontSize: 16,
        ),
      ),
    ],
  );
}
