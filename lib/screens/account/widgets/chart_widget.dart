import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart extends StatefulWidget {
  const Chart({super.key});

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        series: <SplineSeries<EventData, String>>[
          SplineSeries<EventData, String>(
            dataSource: <EventData>[
              EventData(100, 'mon'),
              EventData(20, 'tue'),
              EventData(40, 'wed'),
              EventData(15, 'sat'),
            ],
            xValueMapper: (EventData sales, _) => sales.year,
            yValueMapper: (EventData sales, _) => sales.sales,
          ),
        ],
      ),
    );
  }
}

class EventData {
  EventData(this.sales, this.year);

  final String year;
  final int sales;
}
