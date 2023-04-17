import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

import 'package:petai_care/screens/account/sphelper.dart';
import 'package:petai_care/screens/account/widgets/chart_widget.dart';
import 'package:petai_care/screens/account/performance.dart';

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
  //tablecalendar
  bool calenderHide = false;
  bool chartHide = true;
  //offstage
  List day = ['1일', '1주', '1개월', '1년'];
  int index_color = 0;
  //chart
  Map<String, List> mySelectedEvents = <String, List>{};
  //tablecalendar 용
  List<Performance> performances = [];
  //로컬 저장용
  final amountController = TextEditingController();
  final descpController = TextEditingController();
  final SPHelper helper = SPHelper();

  XFile? _image;
  final ImagePicker picker = ImagePicker();
  String scannedText = "";
  //_getfromimage

  @override
  void initState() {
    helper.init().then((value) => updateScreen());
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

  Future<dynamic> _showAddEventDialog() async {
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
                savePerformance();
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

  Future savePerformance() async {
    int id = helper.getCounter() + 1;
    Performance newPerformance = Performance(id, _selectedDay.toString(),
        amountController.text, descpController.text);

    helper.writePerformance(newPerformance).then((_) {
      helper.setCounter();
      updateScreen();
    });

    amountController.clear();
    descpController.clear();
  }

  Future _getFromImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        _image = XFile(pickedFile.path);
      });
      getRecognizedText(_image!); //이미지를 가져온 뒤 텍스트를 인식하는 함수
    }
  }

  void getRecognizedText(XFile image) async {
    final InputImage inputImage = InputImage.fromFilePath(image.path);
    final TextRecognizer textRecognizer =
        GoogleMlKit.vision.textRecognizer(script: TextRecognitionScript.korean);

    RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    await textRecognizer.close();
    scannedText = "";
    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        scannedText = "$scannedText${line.text}\n";
      }
    }
    setState(() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => _buildRecognizedText(),
        ),
      );
    });
  }

  Widget _buildRecognizedText() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('인식된 텍스트'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(scannedText),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('돌아가기'),
            ),
          ],
        ),
      ),
    );
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
          Column(
            children: [
              Offstage(
                offstage: calenderHide,
                child: TableCalendar(
                  locale: 'ko_KR',
                  focusedDay: _focusedDay,
                  firstDay: DateTime(2023),
                  lastDay: DateTime(2040),
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
              Offstage(
                  offstage: chartHide,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    borderRadius: BorderRadius.circular(10),
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
                      ),
                      const SizedBox(height: 20),
                      const Chart(),
                    ],
                  )),
            ],
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
          const SizedBox(height: 15),
          Expanded(
            child: ListView(
              children: getContent(),
            ),
          )
          /*..._listOfDayEvents(_selectedDay!).map(
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
          )*/
        ],
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.add_event,
        spacing: 12,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.camera_alt),
            label: '카메라',
            onTap: () {
              _getFromImage(ImageSource.camera);
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.picture_in_picture),
            label: '갤러리',
            onTap: () {
              _getFromImage(ImageSource.gallery);
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.add),
            label: '직접입력',
            onTap: () => _showAddEventDialog(),
          )
        ],
      ),
    );
  }

  List<Widget> getContent() {
    List<Widget> tiles = [];
    for (var performance in performances) {
      tiles.add(Dismissible(
        key: UniqueKey(),
        onDismissed: (_) {
          helper
              .deletePerformance(performance.id)
              .then((value) => updateScreen());
        },
        child: ListTile(
          leading: const Icon(
            Icons.local_hospital,
            color: Colors.blue,
            size: 40,
          ),
          title: Text("${performance.amount}원"),
          subtitle: Text(performance.description),
        ),
      ));
    }
    return tiles;
  }

  void updateScreen() {
    performances = helper.readPerformances();
    setState(() {});
  }
}
