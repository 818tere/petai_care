import 'dart:async';
import 'package:petai_care/screens/account/sphelper.dart';
import 'package:petai_care/screens/account/performance.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:petai_care/screens/account/widgets/bar_widget.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/src/widgets/image.dart' as uploadImage;

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  final DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  //tablecalendar
  bool calenderHide = false;
  bool chartHide = true;

  //chart
  Map<String, List<dynamic>> mySelectedEvents = {};
  //tablecalendar 용
  List<Performance> performances = [];
  //로컬 저장용
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descpController = TextEditingController();
  final SPHelper helper = SPHelper();

  @override
  void initState() {
    helper.init().then((value) => updateScreen());
    super.initState();
    _selectedDay = _focusedDay;
    initializeDateFormatting();
  }

  List listOfDayEvents(DateTime day) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(day);

    if (mySelectedEvents[formattedDate] != null) {
      return [mySelectedEvents[formattedDate]![0]];
    } else {
      return [];
    }
  }

  Future savePerformance(
      String amount, String descp, String selectedItem) async {
    int id = helper.getCounter() + 1;

    setState(() {
      if (mySelectedEvents[DateFormat('yyyy-MM-dd').format(_selectedDay!)] !=
          null) {
        mySelectedEvents[DateFormat('yyyy-MM-dd').format(_selectedDay!)]?.add(
          {
            'category': selectedItem,
            'amount': amount,
            'descp': descp,
          },
        );
      } else {
        mySelectedEvents[DateFormat('yyyy-MM-dd').format(_selectedDay!)] = [
          {
            'category': selectedItem,
            'amount': amount,
            'descp': descp,
          },
        ];
      }
    });

    Performance performance = Performance(
      id,
      _selectedDay.toString(),
      amount.toString(),
      descp,
      selectedItem,
    );

    helper.writePerformance(performance).then((_) {
      helper.setCounter();
      updateScreen();
    });

    amountController.clear();
    descpController.clear();
    updateScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Offstage(
                  offstage: chartHide,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ...List.generate(
                                    4,
                                    (index) => GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          index_color = index;
                                        });
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          color: index_color == index
                                              ? Colors.blue
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          day[index],
                                          style: TextStyle(
                                              color: index_color == index
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),*/
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            '     이번주 소비내역',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 1,
                          ),
                          Text(
                            '   132,500원   ',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const SizedBox(
                        child: BarWidget(),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '소비내역',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              calenderHide = false;
                              chartHide = true;
                            });
                          },
                          child: const Icon(Icons.calendar_month_outlined,
                              size: 30, color: Colors.black),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              chartHide = false;
                              calenderHide = true;
                            });
                          },
                          child: const Icon(Icons.bar_chart,
                              size: 30, color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getContent(
      DateTime selectedDate, Map<String, List<dynamic>> mySelectedEvents) {
    final formatCurrency = NumberFormat.simpleCurrency(
        locale: 'ko_KR', name: '', decimalDigits: 0);
    List<Widget> tiles = [];
    // Get the performance data for the selected date
    List<Performance> selectedPerformances = performances
        .where((performance) => performance.date == selectedDate.toString())
        .toList();

    // Add the performance data to the `mySelectedEvents` map
    for (var performance in selectedPerformances) {
      mySelectedEvents[performance.date] = [
        {
          'category': performance.category,
          'amount': performance.amount,
          'descp': performance.description,
        },
      ];
    }

    // Filter the performances based on the selected date
    List<Performance> filteredPerformances = performances.where((performance) {
      // Convert the stored date string to DateTime format for comparison
      DateTime performanceDate = DateTime.parse(performance.date);
      // Format the date as 'yyyy-MM-dd' for the eventLoader

      return performanceDate.year == selectedDate.year &&
          performanceDate.month == selectedDate.month &&
          performanceDate.day == selectedDate.day;
    }).toList();

    for (var performance in filteredPerformances) {
      tiles.add(
        ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: uploadImage.Image.asset(
              'assets/accountimages/${performance.category}.png',
            ),
          ),
          title:
              Text('${formatCurrency.format(num.parse(performance.amount))}원'),
          subtitle: Text(performance.description),
        ),
      );
    }
    return tiles;
  }

  void updateScreen() {
    performances = helper.readPerformances();
    setState(() {});
  }
}
