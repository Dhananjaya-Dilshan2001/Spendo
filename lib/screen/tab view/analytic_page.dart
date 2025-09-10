import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:spendo/core/bloc/bloc/user_bloc.dart';
import 'package:spendo/screen/color&theme.dart';
import 'package:spendo/screen/common_component/graph_card.dart';

class AnalyticPage extends StatelessWidget {
  const AnalyticPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserError) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is UserLoaded) {
          print("Created Analytic Page");
          double totalIncome = 0;
          double totalExpense = 0;
          double balance = 0;
          for (var transaction in state.user.transactions!) {
            if (transaction.isExpense) {
              totalExpense += transaction.amount;
            } else {
              totalIncome += transaction.amount;
            }
          }
          balance = totalIncome - totalExpense;
          balance = balance.abs();
          double maxValue = [
            state.user.monthlyBudget ?? 0.0,
            state.user.monthlyExpectedIncome ?? 0.0,
            state.user.monthlyExpectedOutcome ?? 0.0,
            totalIncome,
            totalExpense,
          ].reduce((a, b) => a > b ? a : b);
          return Container(
            child: ListView(
              children: [
                SizedBox(height: height * 0.01),
                Center(
                  child: Text(
                    'Analytics',
                    style: TextStyle(
                      fontSize: width * 0.05,
                      fontWeight: FontWeight.bold,
                      color: AppColors.color1,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.01),
                Center(
                  child: Text(
                    '${DateFormat('MMMM').format(DateTime.now())} ',
                    style: TextStyle(
                      fontSize: width * 0.05,
                      fontWeight: FontWeight.bold,
                      color: AppColors.color1,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.01),
                SizedBox(
                  height: 200,
                  child: BarChart(
                    BarChartData(
                      maxY: maxValue,
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
                              toY: balance,
                              color: AppColors.color1,
                              width: 20,
                              borderRadius: BorderRadius.zero,
                            ),
                            BarChartRodData(
                              toY: state.user.monthlyBudget ?? 0.0,
                              color: AppColors.color1.withOpacity(0.3),
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
                              toY: totalIncome,
                              color: AppColors.color3,
                              width: 20,
                              borderRadius: BorderRadius.zero,
                            ),
                            BarChartRodData(
                              toY: state.user.monthlyExpectedIncome ?? 0.0,
                              color: AppColors.color3.withOpacity(0.3),
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
                              toY: totalExpense,
                              color: AppColors.color2,
                              width: 20,
                              borderRadius: BorderRadius.zero,
                            ),
                            BarChartRodData(
                              toY: state.user.monthlyExpectedOutcome ?? 0.0,
                              color: AppColors.color2.withOpacity(0.3),
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
                      _buildLegendItem(
                        Color(0xFF5A54D6),
                        'Monthly Balance',
                        true,
                      ),
                      _buildLegendItem(
                        Color(0xFF9B9BEB),
                        'Target Balance',
                        false,
                      ),
                      _buildLegendItem(
                        Color(0xFF2EC4B6),
                        'Monthly income',
                        true,
                      ),
                      _buildLegendItem(
                        Color(0xFF9DEAE1),
                        'Target income',
                        false,
                      ),
                      _buildLegendItem(
                        Color(0xFFFF6F61),
                        'Monthly Expences',
                        true,
                      ),
                      _buildLegendItem(
                        Color(0xFFFFB3AB),
                        'Expected Expenses',
                        false,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.03),
                GraphCard(title: 'All'),
                SizedBox(height: height * 0.03),
                GraphCard(title: 'Income'),
                SizedBox(height: height * 0.03),
                GraphCard(title: 'Outcome'),
              ],
            ),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
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
