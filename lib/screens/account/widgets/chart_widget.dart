import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:petai_care/screens/account/performance.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:petai_care/screens/account/sphelper.dart';

class Chart extends StatefulWidget {
  const Chart({super.key});

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  final SPHelper spHelper = SPHelper();
  List<Performance> performanceData = [];

  List<Performance> parsePerformanceList(String json) {
    final List<dynamic> performanceList = jsonDecode(json);
    return performanceList.map((item) => Performance.fromJson(item)).toList();
  }

  @override
  void initState() {
    super.initState();
    initSPHelper();
    readPerformanceData();
  }

  Future<void> initSPHelper() async {
    await spHelper.init();
  }

  void readPerformanceData() {
    performanceData = spHelper.readPerformances();
    performanceData.sort((a, b) => a.date.compareTo(b.date));

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(
          labelIntersectAction: AxisLabelIntersectAction.rotate45,
        ),
        series: <SplineSeries<Performance, String>>[
          SplineSeries<Performance, String>(
            dataSource: performanceData,
            xValueMapper: (Performance performance, _) {
              DateTime dateTime =
                  DateFormat('yyyy-MM-dd').parse(performance.date);
              return DateFormat('MMM dd').format(dateTime);
            },
            yValueMapper: (Performance performance, _) =>
                double.parse(performance.amount),
          ),
        ],
      ),
    );
  }
}
