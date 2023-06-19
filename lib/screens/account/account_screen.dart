import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:http/http.dart' as http;
import 'package:petai_care/screens/account/models/image_model.dart';
import 'dart:convert';
import 'package:petai_care/screens/account/sphelper.dart';
import 'package:petai_care/screens/account/performance.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:petai_care/screens/account/widgets/bar_widget.dart';
import 'package:petai_care/screens/account/widgets/direct_dialog.dart';
import 'package:petai_care/screens/account/widgets/recognizedText.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/src/widgets/image.dart' as uploadImage;

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
  Map<String, List<dynamic>> mySelectedEvents = {};
  //tablecalendar 용
  List<Performance> performances = [];
  //로컬 저장용
  var amountController = TextEditingController();
  var descpController = TextEditingController();
  final SPHelper helper = SPHelper();
  final ImagePicker picker = ImagePicker();
  bool isLoading = false;
  //_getfromimage
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final user = FirebaseAuth.instance.currentUser;
  CollectionReference userReference =
      FirebaseFirestore.instance.collection('users');
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

    final collectionReference = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('performances');

    final newPerformance = {
      'date': _selectedDay.toString(),
      'amount': amount.toString(),
      'descp': descp,
      'category': selectedItem,
    };
    await collectionReference.doc(user!.uid).set(newPerformance);

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

  Future _getFromImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    final File imagefile = File(pickedFile!.path);
    String postId = const Uuid().v4();
    Reference storageReference =
        _firebaseStorage.ref().child('account_image/$postId');

    UploadTask storageUploadTask = storageReference.putFile(imagefile); //파일 업로드
    await storageUploadTask;

    String downloadURL = await storageReference.getDownloadURL();
    postId = const Uuid().v4();
    setState(() {
      isLoading = true;
    });
    getRecognizedText(pickedFile, downloadURL);
  }

  Future getRecognizedText(XFile image, String downloadURL) async {
    const String apiUrl =
        'https://c5ow50d89i.apigw.ntruss.com/custom/v1/21848/74ec55cb84097108fb278ca259460e9cfcde072e550ba9a68e3e5dca84f7b0fc/infer';
    const String secretKey = 'cVhCeGNBVmh6RmxnWVlOTm5Kc2pYU3NrWmpkd3d2ZUk=';

    var requestJson = {
      'version': 'V1',
      'requestId': 'test',
      'timestamp': 0,
      'images': [
        {'name': 'tmp', 'format': 'jpg', 'url': downloadURL}
      ]
    };
    var headers = {
      'Content-Type': 'application/json',
      'X-OCR-SECRET': secretKey
    };
    var response = await http.post(Uri.parse(apiUrl),
        headers: headers, body: jsonEncode(requestJson));

    final ImageModel imageModel = imageModelFromJson(response.body);

    setState(() {
      isLoading = false;

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => RecognizedTextScreen(
              image: image,
              imageModel: imageModel,
              savePerformance: savePerformance),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
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
                          selectedDayPredicate: (day) =>
                              isSameDay(_selectedDay, day),
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
                          eventLoader: listOfDayEvents,
                        ),
                      ),
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
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
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
                  ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: getContent(_selectedDay!, mySelectedEvents),
                  ),
                ],
              ),
            ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.add_event,
        label: const Text('내역 추가'),
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
            label: '영수증 인식',
            onTap: () {
              _getFromImage(ImageSource.gallery);
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.add),
            label: '직접입력',
            onTap: () => showDialog(
              context: context,
              builder: (BuildContext context) => DirectDialog(
                amountController: amountController,
                descpController: descpController,
                helper: helper,
                mySelectedEvents: mySelectedEvents,
                selectedDay: _selectedDay,
                savePerformance: savePerformance,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> getContent(
      DateTime selectedDate, Map<String, List<dynamic>> mySelectedEvents) {
    final formatCurrency = NumberFormat.simpleCurrency(
        locale: 'ko_KR', name: '', decimalDigits: 0);
    List<Widget> tiles = [];

    /*final collectionReference = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('performances');
    // Fetch the performance documents for the selected date
    collectionReference
        .where('date', isEqualTo: selectedDate.toString())
        .get()
        .then((querySnapshot) {
      // Iterate over the query snapshot and add the performance data to the tiles
      for (var documentSnapshot in querySnapshot.docs) {
        final performanceData = documentSnapshot.data();
        final category = performanceData['category'];
        final amount = performanceData['amount'];
        final descp = performanceData['descp'];

        tiles.add(
          Slidable(
            key: Key(documentSnapshot.id),
            endActionPane: ActionPane(
              extentRatio: 0.7,
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (_) {
                    documentSnapshot.reference.delete().then((value) {
                      updateScreen();
                    });
                  },
                  backgroundColor: const Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  label: '삭제',
                ),
              ],
            ),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.grey.shade300, width: 1),
              ),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: uploadImage.Image.asset(
                  'assets/accountimages/$category.png',
                ),
              ),
              title: Text('${formatCurrency.format(num.parse(amount))}원'),
              subtitle: Text(descp),
            ),
          ),
        );
      }
    });*/
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
    print(mySelectedEvents);
    print(listOfDayEvents(selectedDate));
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
        Slidable(
          key: Key(performance.id.toString()),
          endActionPane: ActionPane(
            extentRatio: 0.7,
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (_) {
                  helper
                      .deletePerformance(performance.id)
                      .then((value) => updateScreen());
                },
                backgroundColor: const Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                label: '삭제',
              ),
            ],
          ),
          child: ListTile(
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
            title: Text(
                '${formatCurrency.format(num.parse(performance.amount))}원'),
            subtitle: Text(performance.description),
          ),
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
