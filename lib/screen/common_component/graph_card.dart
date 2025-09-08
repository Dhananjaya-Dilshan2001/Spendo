import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spendo/core/bloc/bloc/user_bloc.dart';

class GraphCard extends StatelessWidget {
  final String title;
  const GraphCard({super.key, required this.title});

  List<String> generateCategoryList(UserLoaded state, String title) {
    List<String> categories = [];
    if (title == 'Income') {
      categories =
          state.user.transactions!
              .where((tx) => !tx.isExpense)
              .map((tx) => tx.category)
              .toSet()
              .toList();
    } else if (title == 'Outcome') {
      categories = [
        ...state.user.transactions!
            .where((tx) => tx.isExpense)
            .map((tx) => tx.category)
            .toSet()
            .toList(),
      ];
    } else if (title == 'All') {
      categories = [
        ...state.user.categories!
            .map((category) => category.toString())
            .toSet()
            .toList(),
      ];
    }
    return categories;
  }

  // Generates a list of visually distinct, colorful colors.
  List<Color> generateColorList(int length) {
    List<Color> colors = [];
    for (int i = 0; i < length; i++) {
      // Use HSV color space to generate evenly spaced hues
      final double hue = (360.0 * i / length) % 360;
      colors.add(HSVColor.fromAHSV(1.0, hue, 0.7, 0.95).toColor());
    }
    return colors;
  }

  @override
  Widget build(BuildContext context) {
    final Color mainColor = Color(0xFF5A54D6);
    final Color lightBg = Color(0xFFF1F5FB);
    final Color incomeColor = Color(0xFF2EC4B6);
    // Pie chart data
    final List<_PieChartSection> sections = [
      _PieChartSection(color: mainColor, value: 40, label: 'Monthly budget'),
      _PieChartSection(
        color: mainColor.withOpacity(0.7),
        value: 25,
        label: 'Monthly budget',
      ),
      _PieChartSection(
        color: mainColor.withOpacity(0.5),
        value: 15,
        label: 'Monthly budget',
      ),
      _PieChartSection(color: incomeColor, value: 12, label: 'Monthly income'),
      _PieChartSection(
        color: incomeColor.withOpacity(0.7),
        value: 8,
        label: 'Monthly income',
      ),
    ];
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is UserError) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is UserLoaded) {
          List<String> categories = generateCategoryList(state, title);
          List<Color> colors = generateColorList(categories.length);
          sections.clear();
          for (int i = 0; i < categories.length; i++) {
            sections.add(
              _PieChartSection(
                color: colors[i],
                value: 100.0 / categories.length,
                label: categories[i],
              ),
            );
          }
          return Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: lightBg,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Pie chart and title
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: mainColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Pie chart
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: CustomPaint(
                        painter: PieChartPainter(sections: sections),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 32),
                // Legend
                Expanded(
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 16,
                    runSpacing: 8,
                    children: [
                      for (int i = 0; i < categories.length; i++)
                        _LegendItem(color: colors[i], text: categories[i]),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

class _PieChartSection {
  final Color color;
  final double value;
  final String label;
  _PieChartSection({
    required this.color,
    required this.value,
    required this.label,
  });
}

class PieChartPainter extends CustomPainter {
  final List<_PieChartSection> sections;
  PieChartPainter({required this.sections});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    double total = sections.fold(0, (sum, s) => sum + s.value);
    double startRadian = -3.14 / 2;

    for (final section in sections) {
      final sweepRadian = (section.value / total) * 2 * 3.14;
      final paint =
          Paint()
            ..color = section.color
            ..style = PaintingStyle.fill;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startRadian,
        sweepRadian,
        true,
        paint,
      );
      startRadian += sweepRadian;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String text;
  const _LegendItem({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 8),
        Text(text, style: TextStyle(color: Color(0xFF5A54D6), fontSize: 18)),
      ],
    );
  }
}
