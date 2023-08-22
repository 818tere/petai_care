import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({super.key});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  User user = FirebaseAuth.instance.currentUser!;
  final formatCurrency =
      NumberFormat.simpleCurrency(locale: "ko_KR", name: "", decimalDigits: 0);

  DateTime _selectedMonth = DateTime.now();

  void _showPreviousMonth() {
    setState(() {
      _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month - 1);
    });
  }

  void _showNextMonth() {
    setState(() {
      _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month + 1);
    });
  }

  bool _isNextMonthAvailable() {
    final now = DateTime.now();
    final lastAvailableMonth = DateTime(now.year, now.month);
    return _selectedMonth.isBefore(lastAvailableMonth);
  }

  Color _getRandomColor() {
    final random = Random();
    final red = random.nextInt(256);
    final green = random.nextInt(256);
    final blue = random.nextInt(256);

    return Color.fromRGBO(red, green, blue, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('account')
            .doc(user.uid)
            .collection('markers')
            .orderBy('date')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!.docs;
            final Map<String, Map<String, List<Map<String, dynamic>>>>
                groupedData = {};

            // Organize data by month and category, and calculate total sum
            for (var doc in data) {
              final dateString = doc['date'] as String;
              final date = DateTime.parse(dateString);
              final month = DateFormat('MM').format(date);
              final category = doc['category'];

              if (_selectedMonth.year == date.year &&
                  _selectedMonth.month == date.month) {
                if (groupedData[month] == null) {
                  groupedData[month] = {};
                }

                if (groupedData[month]![category] == null) {
                  groupedData[month]![category] = [];
                }

                groupedData[month]![category]!
                    .add(doc.data() as Map<String, dynamic>);
              }
            }

            // Calculate total sum for the month
            final totalSum = groupedData.values
                .expand((categories) =>
                    categories.values.expand((categoryList) => categoryList))
                .map<int>((item) => int.parse(item['amount']))
                .fold<int>(0, (sum, amount) => sum + amount);

            // Display organized data using a ListView
            return groupedData.keys.isEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            IconButton(
                                icon: const Icon(Icons.arrow_left),
                                onPressed: _showPreviousMonth),
                            const Text(
                              '이달의 소비가 없습니다',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.arrow_right),
                              onPressed: _isNextMonthAvailable()
                                  ? _showNextMonth
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : ListView.builder(
                    itemCount: groupedData.keys.length,
                    itemBuilder: (context, index) {
                      final month = groupedData.keys.elementAt(index);
                      final categories = groupedData[month] ?? {};

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                IconButton(
                                    icon: const Icon(Icons.arrow_left),
                                    onPressed: _showPreviousMonth),
                                Text(
                                  '$month월 소비',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.arrow_right),
                                  onPressed: _isNextMonthAvailable()
                                      ? _showNextMonth
                                      : null,
                                ),
                              ],
                            ),
                          ),
                          // Display total sum
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              '${formatCurrency.format(totalSum)}원',
                              style: const TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height *
                                0.26, // Adjust the height as needed
                            child: PieChart(
                              PieChartData(
                                sections: categories.keys.map((category) {
                                  final categorySum = categories[category]!
                                      .fold<int>(
                                          0,
                                          (sum, item) =>
                                              sum + int.parse(item['amount']));
                                  final percentage =
                                      (categorySum / totalSum) * 100;

                                  return PieChartSectionData(
                                    value: percentage,
                                    title: '${percentage.toStringAsFixed(2)}%',
                                    color: category == '병원비'
                                        ? (Colors.red.shade200)
                                        : (Colors.blue
                                            .shade200), // You can customize the colors
                                    radius:
                                        95, // Adjust the size of the pie chart
                                    titleStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }).toList(),
                                sectionsSpace:
                                    0, // Adjust the space between sections
                                centerSpaceRadius:
                                    0, // Adjust the center space radius
                              ),
                            ),
                          ),
                          for (var category in categories.keys)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: const Color(0xffF7F2F9)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundColor: category ==
                                                        '병원비'
                                                    ? (Colors.red.shade200)
                                                    : (Colors.blue.shade200),
                                                child: category == '병원비'
                                                    ? const Icon(
                                                        Icons.local_hospital,
                                                      )
                                                    : const Icon(
                                                        Icons.shopping_bag),
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                category,
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            '${formatCurrency.format(categories[category]!.fold<int>(0, (sum, item) => sum + int.parse(item['amount'])))}원'
                                            ' (${(categories[category]!.fold<int>(0, (sum, item) => sum + int.parse(item['amount'])) / totalSum * 100).toStringAsFixed(1)}%)',
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: categories[category]!.length,
                                      itemBuilder: (context, index) {
                                        final item =
                                            categories[category]![index];
                                        return ListTile(
                                          title: Text(
                                            '${item['amount']}원',
                                            textAlign: TextAlign.right,
                                          ),
                                          subtitle: Text(
                                            item['descp'],
                                            textAlign: TextAlign.right,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
