import 'package:flutter/material.dart';

class GraphCard extends StatelessWidget {
  const GraphCard({super.key});

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
                'Income',
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
                  painter: _PieChartPainter(sections: sections),
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
                _LegendItem(
                  color: mainColor,
                  text: 'Monthly budget',
                  bold: true,
                ),
                _LegendItem(
                  color: mainColor.withOpacity(0.7),
                  text: 'Monthly budget',
                ),
                _LegendItem(
                  color: mainColor.withOpacity(0.5),
                  text: 'Monthly budget',
                ),
                _LegendItem(
                  color: incomeColor,
                  text: 'Monthly income',
                  bold: true,
                ),
                _LegendItem(
                  color: incomeColor.withOpacity(0.7),
                  text: 'Monthly income',
                ),
              ],
            ),
          ),
        ],
      ),
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

class _PieChartPainter extends CustomPainter {
  final List<_PieChartSection> sections;
  _PieChartPainter({required this.sections});

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
  final bool bold;
  const _LegendItem({
    required this.color,
    required this.text,
    this.bold = false,
  });

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
        Text(
          text,
          style: TextStyle(
            color: Color(0xFF5A54D6),
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
