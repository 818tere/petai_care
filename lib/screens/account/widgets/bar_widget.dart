import 'package:flutter/material.dart';
import 'package:petai_care/screens/account/widgets/bar_graph.dart';

class BarWidget extends StatefulWidget {
  const BarWidget({Key? key}) : super(key: key);

  @override
  State<BarWidget> createState() => _BarWidgetState();
}

class _BarWidgetState extends State<BarWidget> {
  List<double> weeklySummary = [
    4.40,
    2.50,
    42.42,
    10.50,
    100.20,
    88.99,
    90.10,
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 210,
          width: double.infinity,
          child: BarGraph(weeklySummary: weeklySummary),
        ),
      ],
    );
  }
}
