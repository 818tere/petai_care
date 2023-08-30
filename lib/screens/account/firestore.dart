import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:uuid/uuid.dart';

import 'analysis_screen.dart';
import 'models/image_model.dart';
import 'widgets/recognizedText.dart';

class FireStore extends StatefulWidget {
  const FireStore({Key? key}) : super(key: key);

  @override
  _FireStoreState createState() => _FireStoreState();
}

enum CategoryLabel {
  hospital('병원비', Icons.sentiment_satisfied_outlined),
  etc(
    '양육비',
    Icons.cloud_outlined,
  );

  const CategoryLabel(this.label, this.icon);
  final String label;
  final IconData icon;
}

class _FireStoreState extends State<FireStore> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  bool calendarHide = false;
  bool chartHide = true;

  User user = FirebaseAuth.instance.currentUser!;

  final formatCurrency =
      NumberFormat.simpleCurrency(locale: 'ko_KR', name: '', decimalDigits: 0);

  CategoryLabel? selectedCategory;

  Map<DateTime, List<dynamic>> calendarMarker = {};

  List _getEventsForDay(DateTime day) {
    if (calendarMarker[day] != null) {
      return calendarMarker[day]!;
    } else {
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    _selectedDay = _focusedDay;
    _loadMarkers();
  }

  Future<void> _loadMarkers() async {
    late CollectionReference markers = FirebaseFirestore.instance
        .collection('account')
        .doc(user.uid)
        .collection('markers');

    //Firestore에서 모든 데이터 가져오기
    QuerySnapshot querySnapshot = await markers.get();

    for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
      DateTime date = DateTime.parse(docSnapshot['date']);

      if (calendarMarker[date] != null) {
        calendarMarker[date]!.add(docSnapshot.data());
      } else {
        calendarMarker[date] = [docSnapshot.data()];
      }
    }

    setState(() {});
  }

  Future<void> _update(DocumentSnapshot docSnapshot) async {
    TextEditingController amountController = TextEditingController();
    TextEditingController descpController = TextEditingController();

    late CollectionReference items = FirebaseFirestore.instance
        .collection('account')
        .doc(user.uid)
        .collection(_selectedDay.toString());

    amountController.text = docSnapshot['amount'];
    descpController.text = docSnapshot['descp'];

    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.35,
          child: Padding(
            padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    const Text(
                      '내역 수정',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () async {
                            final String amount = amountController.text;
                            final String descp = descpController.text;
                            items.doc(docSnapshot.id).update({
                              'amount': amount,
                              'descp': descp,
                            });
                            amountController.clear();
                            descpController.clear();
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            '수정',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey.shade400,
                ),
                TextField(
                  controller: amountController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
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
          ),
        );
      },
    );
  }

  Future<void> _create() async {
    TextEditingController amountController = TextEditingController();
    TextEditingController descpController = TextEditingController();
    TextEditingController categoryController = TextEditingController();
    late CollectionReference items = FirebaseFirestore.instance
        .collection('account')
        .doc(user.uid)
        .collection(_selectedDay.toString());

    late CollectionReference markers = FirebaseFirestore.instance
        .collection('account')
        .doc(user.uid)
        .collection('markers');

    final List<DropdownMenuEntry<CategoryLabel>> categoryEntries =
        <DropdownMenuEntry<CategoryLabel>>[];
    for (final CategoryLabel icon in CategoryLabel.values) {
      categoryEntries.add(
          DropdownMenuEntry<CategoryLabel>(value: icon, label: icon.label));
    }

    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: Padding(
            padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    const Text(
                      '내역 추가',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () async {
                            Navigator.of(context).pop();

                            final String amount = amountController.text;
                            final String descp = descpController.text;
                            final String category = categoryController.text;
                            await items.add({
                              'amount': amount,
                              'descp': descp,
                              'category': category,
                              'date': _selectedDay.toString(),
                            });
                            await markers.add({
                              'amount': amount,
                              'descp': descp,
                              'category': category,
                              'date': _selectedDay.toString(),
                            });
                            if (calendarMarker[
                                    DateTime.parse(_selectedDay.toString())] !=
                                null) {
                              calendarMarker[
                                      DateTime.parse(_selectedDay.toString())]
                                  ?.add({
                                'amount': amount,
                                'descp': descp,
                                'date': _selectedDay.toString(),
                              });
                            } else {
                              calendarMarker[
                                  DateTime.parse(_selectedDay.toString())] = [
                                {
                                  'amount': amount,
                                  'descp': descp,
                                  'date': _selectedDay.toString(),
                                }
                              ];
                            }
                          },
                          child: const Text(
                            '저장',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey.shade400,
                ),
                TextField(
                  controller: amountController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: '금액',
                    labelStyle: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                TextField(
                  controller: descpController,
                  decoration: const InputDecoration(
                    labelText: '내용',
                    labelStyle: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                DropdownMenu<CategoryLabel>(
                  width: MediaQuery.of(context).size.width * 0.91,
                  controller: categoryController,
                  enabled: true,
                  label: const Text('카테고리', style: TextStyle(fontSize: 18)),
                  dropdownMenuEntries: categoryEntries,
                  inputDecorationTheme: const InputDecorationTheme(
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  onSelected: (CategoryLabel? icon) {
                    setState(() {
                      selectedCategory = icon;
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _delete(String itemId, String markerId) async {
    late CollectionReference items = FirebaseFirestore.instance
        .collection('account')
        .doc(user.uid)
        .collection(_selectedDay.toString());

    await items.doc(itemId).delete();

    setState(() {});
  }

  final ImagePicker picker = ImagePicker();
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  bool isLoading = false;

  Future getFromImage(ImageSource imageSource, DateTime selectedDay) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    final File imagefile = File(pickedFile!.path);
    String postId = const Uuid().v4();
    Reference storageReference =
        _firebaseStorage.ref().child('account_image/$postId');

    UploadTask storageUploadTask = storageReference.putFile(imagefile); //파일 업로드
    await storageUploadTask;

    String downloadURL = await storageReference.getDownloadURL();
    postId = const Uuid().v4();

    await getRecognizedText(pickedFile, downloadURL);
  }

  Future getRecognizedText(XFile image, String downloadURL) async {
    late CollectionReference items = FirebaseFirestore.instance
        .collection('account')
        .doc(user.uid)
        .collection(_selectedDay.toString());

    late CollectionReference markers = FirebaseFirestore.instance
        .collection('account')
        .doc(user.uid)
        .collection('markers');

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

    if (mounted) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => RecognizedTextScreen(
            image: image,
            imageModel: imageModel,
            items: items,
            markers: markers,
            selectedDay: _selectedDay!,
            calendarMarker: calendarMarker,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference items = FirebaseFirestore.instance
        .collection('account')
        .doc(user.uid)
        .collection(_selectedDay.toString());

    CollectionReference markers = FirebaseFirestore.instance
        .collection('account')
        .doc(user.uid)
        .collection('markers');

    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '가계부',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const AnalysisScreen(),
                              ),
                            );
                          },
                          child:
                              const Text('분석', style: TextStyle(fontSize: 20)),
                        )
                      ],
                    ),
                  ),
                ),
                TableCalendar(
                  locale: 'ko_KR',
                  focusedDay: _focusedDay,
                  firstDay: DateTime(2023),
                  lastDay: DateTime(2040),
                  rowHeight: 43,
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
                  eventLoader: _getEventsForDay,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.34,
                  child: StreamBuilder(
                    stream: items.snapshots(),
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (streamSnapshot.hasData) {
                        return ListView.builder(
                          itemCount: streamSnapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final DocumentSnapshot docSnapshot =
                                streamSnapshot.data!.docs[index];

                            return ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                    color: Colors.grey.shade300, width: 1),
                              ),
                              leading: CircleAvatar(
                                backgroundColor: const Color(0xffE6E6E6),
                                child: docSnapshot['category'] == '병원비'
                                    ? const Icon(
                                        Icons.local_hospital,
                                      )
                                    : const Icon(Icons.shopping_bag),
                              ),
                              title: Text('${formatCurrency.format(
                                num.parse(docSnapshot['amount']),
                              )}원'),
                              subtitle: Text(docSnapshot['descp']),
                              trailing: PopupMenuButton<String>(
                                onSelected: (value) {
                                  if (value == "delete") {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: const Text(
                                            "이 항목을 삭제하시겠습니까?",
                                            style: TextStyle(fontSize: 16),
                                            textAlign: TextAlign.center,
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text("취소"),
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(); // 다이얼로그 닫기
                                              },
                                            ),
                                            TextButton(
                                              child: const Text("삭제"),
                                              onPressed: () {
                                                _delete(
                                                    docSnapshot.id, markers.id);
                                                markers
                                                    .where('date',
                                                        isEqualTo:
                                                            docSnapshot['date'])
                                                    .where('amount',
                                                        isEqualTo: docSnapshot[
                                                            'amount'])
                                                    .get()
                                                    .then((value) => value.docs
                                                            .forEach((element) {
                                                          element.reference
                                                              .delete();
                                                        }));
                                                if (calendarMarker[
                                                        DateTime.parse(
                                                            _selectedDay
                                                                .toString())] !=
                                                    null) {
                                                  calendarMarker[DateTime.parse(
                                                          _selectedDay
                                                              .toString())]!
                                                      .removeWhere((element) =>
                                                          element['amount'] ==
                                                          docSnapshot[
                                                              'amount']);
                                                }
                                                setState(() {});
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  } else if (value == "edit") {
                                    _update(docSnapshot);
                                    setState(() {});
                                  }
                                },
                                itemBuilder: (BuildContext context) {
                                  return [
                                    const PopupMenuItem<String>(
                                      value: "delete",
                                      child: Text(
                                        "삭제",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    const PopupMenuItem<String>(
                                      value: "edit",
                                      child: Text(
                                        "수정",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ];
                                },
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: SpeedDial(
        tooltip: '캘린더에 날짜를 선택 후 사용해주세요',
        animatedIcon: AnimatedIcons.add_event,
        label: const Text('내역 추가'),
        spacing: 12,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.camera_alt),
            label: '카메라',
            onTap: () {
              getFromImage(ImageSource.camera, _selectedDay!);
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.picture_in_picture),
            label: '영수증 인식',
            onTap: () {
              getFromImage(ImageSource.gallery, _selectedDay!);
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.add),
            label: '직접입력',
            onTap: () {
              _create();
            },
          )
        ],
      ),
    );
  }
}
