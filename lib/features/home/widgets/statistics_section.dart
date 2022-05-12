import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../statistics/domain/models/statistics_model.dart';
import '../../statistics/providers/statistics_provider.dart';

class StatisticsSection extends StatefulWidget {
  const StatisticsSection({Key? key}) : super(key: key);

  @override
  State<StatisticsSection> createState() => _StatisticsSectionState();
}

class _StatisticsSectionState extends State<StatisticsSection> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer(
        builder: (context, ref, child) {
          return ref.watch(statisticsProvider).when(
                data: (data) => ListView(
                  padding: const EdgeInsets.all(15),
                  children: [
                    _buildGraph(
                      title: "Sales in a month",
                      statistics: data.salesInMonth,
                    ),
                    const SizedBox(height: 30),
                    _buildGraph(
                      title: "Profits in a month",
                      statistics: data.profitInMonth,
                    ),
                    // _buildGraph(title: "Top selling product"),
                    // _buildGraph(title: "Most profitable product"),
                  ],
                ),
                error: (_, __) =>
                    const Center(child: Text("Something went wrong...")),
                loading: () => const Center(child: CircularProgressIndicator()),
              );
        },
      ),
    );
  }

  Widget _buildGraph({
    required String title,
    required StatisticsModel statistics,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: AspectRatio(
            aspectRatio: 1.50,
            child: LineChart(_getLineChartData(statistics)),
          ),
        ),
      ],
    );
  }

  LineChartData _getLineChartData(StatisticsModel statistics) {
    final colorScheme = Theme.of(context).colorScheme;
    return LineChartData(
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: colorScheme.primaryContainer),
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
            getTitlesWidget: (value, metadata) {
              return Text(statistics.xLabel[value.toInt()]);
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, metadata) {
              if (statistics.maxY < value || statistics.minY > value) {
                return const SizedBox.shrink();
              }

              return Text(value.toStringAsFixed(0));
            },
            reservedSize: 40,
          ),
        ),
      ),
      minX: 0,
      maxX: 30,
      minY: (statistics.minY - (statistics.maxY * .1)) //
          .clamp(0, statistics.minY),
      maxY: statistics.maxY + (statistics.maxY * .1),
      lineBarsData: [
        LineChartBarData(
          spots: statistics.dataPoint.entries
              .map((e) => FlSpot(e.key.toDouble(), e.value))
              .toList(),
          isCurved: false,
          barWidth: 5,
          color: colorScheme.primary,
          isStrokeCapRound: true,
          dotData: FlDotData(show: false),
        ),
      ],
    );
  }
}
