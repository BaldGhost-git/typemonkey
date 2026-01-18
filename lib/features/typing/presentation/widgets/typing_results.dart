import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:typingapp/core/themes/sizes.dart';
import 'package:typingapp/core/themes/styles.dart';
import 'package:typingapp/features/typing/application/typing_trainer_viewmodel.dart';
import 'package:typingapp/features/typing/domain/typing_practice.dart';

class TypingResults extends StatelessWidget {
  const TypingResults({super.key, required this.state, required this.vm});

  final TypingTrainerState state;
  final TypingTrainerViewModel vm;

  LineChartBarData get wpmLine => LineChartBarData(
    dotData: FlDotData(show: false),
    color: Colors.green,
    barWidth: AppSizes.primaryBarWidth,
    isCurved: true,
    spots: state.stats!
        .map((stat) => FlSpot(stat.elapsedTimeInSeconds, stat.wpm))
        .toList(),
  );

  LineChartBarData get rawWpmLine => LineChartBarData(
    dotData: FlDotData(show: false),
    dashArray: AppSizes.primaryDashLine,
    color: Colors.green,
    barWidth: AppSizes.primaryBarWidth,
    isCurved: true,
    spots: state.stats!
        .map((stat) => FlSpot(stat.elapsedTimeInSeconds, stat.rawWpm))
        .toList(),
  );

  LineChartBarData get accuracyLine => LineChartBarData(
    dotData: FlDotData(show: false),
    color: Colors.blue[100],
    barWidth: AppSizes.primaryBarWidth,
    isCurved: true,
    spots: state.stats!
        .map((stat) => FlSpot(stat.elapsedTimeInSeconds, stat.accuracy))
        .toList(),
  );

  AxisTitles get leftTitle => AxisTitles(
    axisNameSize: 20,
    axisNameWidget: Text('Words per minute', style: AppStyles.chartTitle),
    sideTitles: SideTitles(
      maxIncluded: false,
      showTitles: true,
      reservedSize: AppSizes.chartTitleBoxSize,
      interval: AppSizes.chartWpmInterval,
      getTitlesWidget: (value, meta) => SideTitleWidget(
        meta: meta,
        child: Text(value.toInt().toString(), style: AppStyles.chartNumbers),
      ),
    ),
  );

  AxisTitles get bottomTitle => AxisTitles(
    axisNameSize: AppSizes.chartTitleTextSize,
    axisNameWidget: Text('Duration', style: AppStyles.chartTitle),
    sideTitles: SideTitles(
      maxIncluded: false,
      showTitles: true,
      reservedSize: AppSizes.chartTitleBoxSize,
      interval: AppSizes.chartTimeInterval(
        state.stats!.last.elapsedTimeInSeconds,
      ),
      getTitlesWidget: (value, meta) => SideTitleWidget(
        meta: meta,
        child: Text(value.toInt().toString(), style: AppStyles.chartNumbers),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('wpm', style: AppStyles.primaryHeading2),
            Text(
              state.stats!.last.wpm.toStringAsFixed(1),
              style: AppStyles.primaryHeading1,
            ),
            Gap(10),
            Text('acc', style: AppStyles.primaryHeading2),
            Text(
              '${state.stats!.last.accuracy.toStringAsFixed(0)}%',
              style: AppStyles.primaryHeading1,
            ),
          ],
        ),
        Gap(10),
        Expanded(
          child: LineChart(
            curve: Curves.bounceOut,
            duration: Duration(seconds: 10),
            LineChartData(
              gridData: FlGridData(show: false),
              minY: 0,
              minX: 1,
              titlesData: FlTitlesData(
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                leftTitles: leftTitle,
                bottomTitles: bottomTitle,
              ),
              lineTouchData: LineTouchData(enabled: false),
              lineBarsData: [wpmLine, rawWpmLine],
            ),
          ),
        ),
        Gap(20),
        IconButton(onPressed: vm.resetTest, icon: Icon(Icons.replay)),
      ],
    );
  }
}
