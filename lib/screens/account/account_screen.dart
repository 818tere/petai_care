import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:petai_care/screens/account/chart_screen.dart';
import 'package:petai_care/screens/account/widgets/chart_widget.dart';
import 'package:uuid/uuid.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  Map<String, List> mySelectedEvents = <String, List>{};

  final amountController = TextEditingController();
  final descpController = TextEditingController();
  String parsedtext = '';

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    initializeDateFormatting();
  }

  List _listOfDayEvents(DateTime day) {
    if (mySelectedEvents[DateFormat('yyyy-MM-dd').format(day)] != null) {
      return mySelectedEvents[DateFormat('yyyy-MM-dd').format(day)]!;
    } else {
      return [];
    }
  }

  _showAddEventDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          '내역 추가',
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: amountController,
              decoration: const InputDecoration(
                labelText: '금액',
              ),
            ),
            TextField(
              controller: descpController,
              decoration: const InputDecoration(
                labelText: '내용',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('취소'),
          ),
          TextButton(
            child: const Text('추가'),
            onPressed: () {
              if (amountController.text.isEmpty &&
                  descpController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('내용이 입력되지 않았습니다.'),
                    duration: Duration(seconds: 2),
                  ),
                );
                return;
              } else {
                setState(() {
                  if (mySelectedEvents[
                          DateFormat('yyyy-MM-dd').format(_selectedDay!)] !=
                      null) {
                    mySelectedEvents[
                            DateFormat('yyyy-MM-dd').format(_selectedDay!)]
                        ?.add(
                      {
                        'amount': amountController.text,
                        'descp': descpController.text,
                      },
                    );
                  } else {
                    mySelectedEvents[
                        DateFormat('yyyy-MM-dd').format(_selectedDay!)] = [
                      {
                        'amount': amountController.text,
                        'descp': descpController.text,
                      },
                    ];
                  }
                });

                amountController.clear();
                descpController.clear();
                Navigator.of(context).pop();
                return;
              }
            },
          ),
        ],
      ),
    );
  }

  Future _getFromImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return;
    }
    var bytes = File(pickedFile.path.toString()).readAsBytesSync();
    String img64 = base64Encode(bytes);

    var url =
        'https://b90884mpg3.apigw.ntruss.com/custom/v1/20868/aef4c9a439c3f08c0e9166742558b78ddafdcc7234cde4d2eed24e7952e9c1f0/infer';
    var secretKey = "ZHhjaGVTSlVUQlNtWW1OUUFnRWdIbUlSTHd3RElQUGk=";
    var uuid = const Uuid();
    var requestID = uuid.v4();

    var payload = {
      'version': 'V2',
      'requestId': requestID,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'images': [
        {
          'format': 'jpg',
          'data':
              'data:image/jpg;base64,${img64.toString()}', // use this instead of url if the image is not public
          'name': 'demo',
        }
      ]
    };
    var postParams = jsonEncode(payload);

    var headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'X-OCR-SECRET': secretKey
    };

    var response =
        await http.post(Uri.parse(url), headers: headers, body: postParams);
    var result = jsonDecode(response.body);

    setState(() {
      result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 55,
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                children: const [
                  Text(
                    '가계부',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Offstage(
                  offstage: false,
                  child: TableCalendar(
                    locale: 'ko_KR',
                    focusedDay: _focusedDay,
                    firstDay: DateTime(2023),
                    lastDay: DateTime(2040),
                    onDaySelected: (selectedDay, focusedDay) {
                      if (!isSameDay(_selectedDay, selectedDay)) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                      }
                    },
                    selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                    onFormatChanged: (format) {
                      if (_calendarFormat != format) {
                        setState(() {
                          _calendarFormat = format;
                        });
                      }
                    },
                    onPageChanged: (focusedDay) {
                      _focusedDay = focusedDay;
                    },
                    eventLoader: _listOfDayEvents,
                  ),
                ),
                const Offstage(offstage: true, child: Chart())
              ],
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                    const Icon(Icons.calendar_month_outlined,
                        size: 30, color: Colors.black),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChartScreen(),
                          ),
                        );
                      },
                      child: const Icon(Icons.bar_chart,
                          size: 30, color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          ..._listOfDayEvents(_selectedDay!).map(
            (myEvents) => ListTile(
              leading: const Icon(
                Icons.local_hospital,
                color: Colors.blue,
                size: 40,
              ),
              title: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text('금액:  ${myEvents['amount']}',
                    style: const TextStyle(fontWeight: FontWeight.w400)),
              ),
              subtitle: Text('내용:  ${myEvents['descp']}',
                  style: const TextStyle(fontWeight: FontWeight.w400)),
            ),
          )
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            heroTag: "b1",
            onPressed: () => _showAddEventDialog(),
            label: const Icon(Icons.add),
          ),
          const SizedBox(width: 10),
          FloatingActionButton.extended(
            heroTag: "b2",
            onPressed: () {
              setState(() {
                _getFromImage();
              });
            },
            label: const Icon(Icons.camera_alt),
          ),
        ],
      ),
    );
  }
}
