import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:typingapp/features/typing/application/typing_trainer_viewmodel.dart';
import 'package:typingapp/features/typing/domain/typing_practice.dart';

class TypingResults extends StatelessWidget {
  const TypingResults({super.key, required this.state, required this.vm});

  final TypingTrainerState state;
  final TypingTrainerViewModel vm;

  LineChartBarData get wpmLine => LineChartBarData(
    dotData: FlDotData(show: false),
    color: Colors.green,
    barWidth: 5,
    isCurved: true,
    spots: state.stats!
        .map((stat) => FlSpot(stat.elapsedTimeInSeconds, stat.wpm))
        .toList(),
  );

  LineChartBarData get rawWpmLine => LineChartBarData(
    dotData: FlDotData(show: false),
    dashArray: [10, 10],
    color: Colors.green,
    barWidth: 5,
    isCurved: true,
    spots: state.stats!
        .map((stat) => FlSpot(stat.elapsedTimeInSeconds, stat.rawWpm))
        .toList(),
  );

  LineChartBarData get accuracyLine => LineChartBarData(
    dotData: FlDotData(show: false),
    color: Colors.blue[100],
    barWidth: 5,
    isCurved: true,
    spots: state.stats!
        .map((stat) => FlSpot(stat.elapsedTimeInSeconds, stat.accuracy))
        .toList(),
  );

  AxisTitles get leftTitle => AxisTitles(
    axisNameSize: 20,
    axisNameWidget: Text(
      'Words per minute',
      style: GoogleFonts.jetBrainsMono(fontSize: 13),
    ),
    sideTitles: SideTitles(
      maxIncluded: false,
      showTitles: true,
      reservedSize: 35,
      interval: 20,
      getTitlesWidget: (value, meta) => SideTitleWidget(
        meta: meta,
        child: Text(
          value.toInt().toString(),
          style: GoogleFonts.jetBrainsMono(fontSize: 12),
        ),
      ),
    ),
  );

  AxisTitles get bottomTitle => AxisTitles(
    axisNameSize: 20,
    axisNameWidget: Text(
      'Duration',
      style: GoogleFonts.jetBrainsMono(fontSize: 13),
    ),
    sideTitles: SideTitles(
      maxIncluded: false,
      showTitles: true,
      reservedSize: 35,
      interval: 1,
      getTitlesWidget: (value, meta) => SideTitleWidget(
        meta: meta,
        child: Text(
          value.toInt().toString(),
          style: GoogleFonts.jetBrainsMono(fontSize: 12),
        ),
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
            Text('wpm', style: GoogleFonts.jetBrainsMono(fontSize: 30)),
            Text(
              state.stats!.last.wpm.toStringAsFixed(1),
              style: GoogleFonts.jetBrainsMono(fontSize: 50),
            ),
            Gap(10),
            Text('acc', style: GoogleFonts.jetBrainsMono(fontSize: 30)),
            Text(
              '${state.stats!.last.accuracy.toStringAsFixed(0)}%',
              style: GoogleFonts.jetBrainsMono(fontSize: 50),
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
