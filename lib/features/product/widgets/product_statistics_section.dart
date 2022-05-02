import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ProductStatisticsSection extends StatefulWidget {
  const ProductStatisticsSection({Key? key}) : super(key: key);

  @override
  State<ProductStatisticsSection> createState() =>
      _ProductStatisticsSectionState();
}

class _ProductStatisticsSectionState extends State<ProductStatisticsSection> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        _buildGraph(title: "Top selling product"),
        _buildGraph(title: "Most profitable product"),
      ],
    );
  }

  Widget _buildGraph({
    required String title,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 20),
        AspectRatio(
          aspectRatio: 1.70,
          child: LineChart(_getLineChartData()),
        ),
      ],
    );
  }

  LineChartData _getLineChartData() {
    final colorScheme = Theme.of(context).colorScheme;
    return LineChartData(
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: colorScheme.primaryContainer),
      ),
      gridData: FlGridData(
        show: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: colorScheme.primaryContainer,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: colorScheme.primaryContainer,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            reservedSize: 42,
          ),
        ),
      ),
      minX: 0,
      maxX: 6.5,
      minY: 0,
      maxY: 10,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
          isCurved: true,
          barWidth: 5,
          color: colorScheme.primary,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
        ),
      ],
    );
  }
}
