import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:typingapp/core/themes/sizes.dart';
import 'package:typingapp/core/themes/styles.dart';
import 'package:typingapp/features/typing/application/typing_trainer_viewmodel.dart';
import 'package:typingapp/features/typing/domain/typing_practice.dart';

class TypingResults extends StatelessWidget {
  const TypingResults({
    super.key,
    required this.state,
    required this.vm,
    required this.language,
  });

  final TypingTrainerState state;
  final TypingTrainerViewModel vm;
  final String language;

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
    axisNameSize: AppSizes.chartTitleReservedArea,
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
    axisNameSize: AppSizes.chartTitleReservedArea,
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
    return Column(
      children: [
        Flexible(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'wpm',
                    style: AppStyles.primaryHeading2.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withAlpha(125),
                    ),
                  ),
                  Text(
                    state.stats!.last.wpm.toStringAsFixed(1),
                    style: AppStyles.primaryHeading1,
                  ),
                  Gap(10),
                  Text(
                    'acc',
                    style: AppStyles.primaryHeading2.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withAlpha(125),
                    ),
                  ),
                  Text(
                    '${state.stats!.last.accuracy.toStringAsFixed(0)}%',
                    style: AppStyles.primaryHeading1,
                  ),
                ],
              ),
              Gap(10),
              Flexible(
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
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'test type',
                  style: AppStyles.chartTitle.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withAlpha(125),
                  ),
                ),
                Text(
                  '${state.type.name} test',
                  style: AppStyles.primaryHeading2.copyWith(fontSize: 20),
                ),
                Text(
                  language,
                  style: AppStyles.primaryHeading2.copyWith(fontSize: 20),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'raw',
                  style: AppStyles.chartTitle.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withAlpha(125),
                  ),
                ),
                Text(
                  state.stats!.last.rawWpm.toStringAsFixed(0),
                  style: AppStyles.primaryHeading2.copyWith(fontSize: 20),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'characters',
                  style: AppStyles.chartTitle.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withAlpha(125),
                  ),
                ),
                Text(
                  '${state.stats!.last.correctChars}/${state.stats!.last.incorrectChars}',
                  style: AppStyles.primaryHeading2.copyWith(fontSize: 20),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'time',
                  style: AppStyles.chartTitle.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withAlpha(125),
                  ),
                ),
                Text(
                  '${state.stats!.last.elapsedTimeInSeconds.toStringAsFixed(0)}s',
                  style: AppStyles.primaryHeading2.copyWith(fontSize: 20),
                ),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(onPressed: vm.resetTest, icon: Icon(Icons.replay)),
          ],
        ),
      ],
    );
  }
}
