import 'package:intl/intl.dart';

import 'dart:math' as math;

class StatisticsModel {
  final Map<int, double> dataPoint;
  final List<String> xLabel;
  final double maxY, minY;

  StatisticsModel._(this.dataPoint, this.xLabel, this.maxY, this.minY);

  factory StatisticsModel.fromMapData(
    Map<DateTime, double> data,
    DateTime startDate,
  ) {
    if (data.isEmpty) return StatisticsModel._({}, [], 0, 0);

    final _dataPoint = <int, double>{};
    final _xLabel = <String>[];

    final _dataValues = data.values.toList();
    final _dataKeys = data.keys.toList();
    final _dateFormattter = DateFormat("dd/MM");
    final _maxValue = _dataValues.reduce((a, b) => math.max(a, b));
    final _minValue = _dataValues.reduce((a, b) => math.min(a, b));

    for (int i = 0; i < data.length; i++) {
      final xCord = _dataKeys[i].difference(startDate).inDays;
      final yCord = _dataValues[i];
      _dataPoint[xCord] = yCord;
    }

    for (var i = 0; i <= 30; i++) {
      _xLabel.add(_dateFormattter.format(startDate.add(Duration(days: i))));
    }

    return StatisticsModel._(_dataPoint, _xLabel, _maxValue, _minValue);
  }
}
