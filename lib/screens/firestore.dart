import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/image.dart' as uploadImage;
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:uuid/uuid.dart';

import 'account/models/image_model.dart';
import 'account/widgets/recognizedText.dart';

class FireStore extends StatefulWidget {
  const FireStore({Key? key}) : super(key: key);

  @override
  _FireStoreState createState() => _FireStoreState();
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

  final TextEditingController amountController = TextEditingController();
  final TextEditingController descpController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

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
          child: Padding(
            padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
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
                    child: const Text('update'))
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _create() async {
    late CollectionReference items = FirebaseFirestore.instance
        .collection('account')
        .doc(user.uid)
        .collection(_selectedDay.toString());

    late CollectionReference markers = FirebaseFirestore.instance
        .collection('account')
        .doc(user.uid)
        .collection('markers');

    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          child: Padding(
            padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                TextField(
                  controller: categoryController,
                  decoration: const InputDecoration(
                    labelText: '카테고리',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () async {
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
                        'date': _selectedDay.toString(),
                      });
                      if (calendarMarker[
                              DateTime.parse(_selectedDay.toString())] !=
                          null) {
                        calendarMarker[DateTime.parse(_selectedDay.toString())]
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
                      amountController.clear();
                      descpController.clear();
                      categoryController.clear();
                      setState(() {});
                    },
                    child: const Text('create'))
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
                Offstage(
                  offstage: calendarHide,
                  child: TableCalendar(
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
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
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

                            return Slidable(
                              endActionPane: ActionPane(
                                extentRatio: 0.7,
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (_) {
                                      _delete(docSnapshot.id, markers.id);
                                      markers
                                          .where('date',
                                              isEqualTo: docSnapshot['date'])
                                          .where('amount',
                                              isEqualTo: docSnapshot['amount'])
                                          .get()
                                          .then((value) =>
                                              value.docs.forEach((element) {
                                                element.reference.delete();
                                              }));
                                      if (calendarMarker[DateTime.parse(
                                              _selectedDay.toString())] !=
                                          null) {
                                        calendarMarker[DateTime.parse(
                                                _selectedDay.toString())]!
                                            .removeWhere((element) =>
                                                element['amount'] ==
                                                docSnapshot['amount']);
                                      }
                                      setState(() {});
                                    },
                                    backgroundColor: const Color(0xFFFE4A49),
                                    foregroundColor: Colors.white,
                                    label: '삭제',
                                  ),
                                  SlidableAction(
                                    onPressed: (_) {
                                      _update(docSnapshot);
                                      setState(() {});
                                    },
                                    backgroundColor: Colors.purple,
                                    foregroundColor: Colors.white,
                                    label: '수정',
                                  ),
                                ],
                              ),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                      color: Colors.grey.shade300, width: 1),
                                ),
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: uploadImage.Image.asset(
                                    'assets/accountimages/${docSnapshot['category']}.png',
                                  ),
                                ),
                                title: Text('${formatCurrency.format(
                                  num.parse(docSnapshot['amount']),
                                )}원'),
                                subtitle: Text(docSnapshot['descp']),
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
