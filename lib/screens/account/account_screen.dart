import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:http/http.dart' as http;
import 'package:petai_care/screens/account/models/image_model.dart';
import 'dart:convert';
import 'package:petai_care/screens/account/sphelper.dart';
import 'package:petai_care/screens/account/widgets/chart_widget.dart';
import 'package:petai_care/screens/account/performance.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/src/widgets/image.dart' as uploadImage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

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
  var amountController = TextEditingController();
  var descpController = TextEditingController();
  final SPHelper helper = SPHelper();

  //XFile? _image;
  final ImagePicker picker = ImagePicker();
  bool isLoading = false;
  //_getfromimage
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  //String _imageURL = '';

  String? selectedItem;
  final List<String> _items = [
    '병원비',
    '양육비',
  ];
  //dropdownbutton 분류 필드
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
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                labelText: '금액',
              ),
            ),
            TextField(
              controller: descpController,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(
                    r'[a-z|A-Z|0-9|ㄱ-ㅎ|ㅏ-ㅣ|가-힣|ᆞ|ᆢ|ㆍ|ᆢ|ᄀᆞ|ᄂᆞ|ᄃᆞ|ᄅᆞ|ᄆᆞ|ᄇᆞ|ᄉᆞ|ᄋᆞ|ᄌᆞ|ᄎᆞ|ᄏᆞ|ᄐᆞ|ᄑᆞ|ᄒᆞ]')),
              ],
              decoration: const InputDecoration(
                labelText: '내용',
              ),
            ),
            DropdownButton<String>(
              value: selectedItem,
              onChanged: ((value) {
                setState(() {
                  selectedItem = value!;
                });
              }),
              items: _items
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Container(
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 20,
                                child: uploadImage.Image.asset(
                                    'assets/accountimages/$e.png'),
                              ),
                              const SizedBox(width: 10),
                              Text(e),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
              selectedItemBuilder: (BuildContext context) => _items
                  .map((e) => Row(
                        children: [
                          SizedBox(
                            width: 20,
                            child: uploadImage.Image.asset(
                                'assets/accountimages/$e.png'),
                          ),
                          const SizedBox(width: 5),
                          Text(e)
                        ],
                      ))
                  .toList(),
              hint: const Text(
                '카테고리',
                style: TextStyle(color: Colors.grey),
              ),
              isExpanded: true,
              dropdownColor: Colors.white,
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
                savePerformance(
                    amountController.text, descpController.text, selectedItem!);
                setState(() {
                  if (mySelectedEvents[
                          DateFormat('yyyy-MM-dd').format(_selectedDay!)] !=
                      null) {
                    mySelectedEvents[
                            DateFormat('yyyy-MM-dd').format(_selectedDay!)]
                        ?.add(
                      {
                        'category': selectedItem,
                        'amount': amountController.text,
                        'descp': descpController.text,
                      },
                    );
                  } else {
                    mySelectedEvents[
                        DateFormat('yyyy-MM-dd').format(_selectedDay!)] = [
                      {
                        'category': selectedItem,
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

  Future savePerformance(
      String amount, String descp, String selectedItem) async {
    int id = helper.getCounter() + 1;

    Performance newPerformance = Performance(
        id, _selectedDay.toString(), amount.toString(), descp, selectedItem);

    helper.writePerformance(newPerformance).then((_) {
      helper.setCounter();
      updateScreen();
    });

    amountController.clear();
    descpController.clear();
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
    //var bytes = File(_image.toString()).readAsBytes();
    //String img64 = base64Encode(await bytes);

    const String apiUrl =
        'https://c5ow50d89i.apigw.ntruss.com/custom/v1/21848/74ec55cb84097108fb278ca259460e9cfcde072e550ba9a68e3e5dca84f7b0fc/infer';
    const String secretKey = 'cVhCeGNBVmh6RmxnWVlOTm5Kc2pYU3NrWmpkd3d2ZUk=';
    /*const String imageUrl =
        'https://kr.object.ncloudstorage.com/petaicare/text1.jpeg';
*/

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
          builder: (context) => _buildRecognizedText(image, imageModel),
        ),
      );
    });
  }

  Widget _buildRecognizedText(XFile image, ImageModel imageModel) {
    String amountTemp = (imageModel.images[0].fields[1].inferText)
        .replaceAll(RegExp('[^0-9\\s]'), '');
    String recognizedAmount = amountTemp;
    String recognizedDescp = imageModel.images[0].fields[0].inferText;
    String recognizedCategory = recognizedDescp.contains('병원') ? '병원비' : '양육비';
    return Scaffold(
      appBar: AppBar(
        title: const Text('영수증 인식확인'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: uploadImage.Image.file(File(image.path)),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('\n* 영수증에서 인식한 정보이며 빈 칸의 항목은 인식불가 항목입니다.\n',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ))
                        ]),
                    const Divider(
                      thickness: 1.5,
                      height: 1,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('분류: ',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                              )),
                          Text(recognizedCategory,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                              )),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 0.3,
                      height: 1,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('사업자명: ',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                              )),
                          Text(imageModel.images[0].fields[0].inferText,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                              )),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 0.3,
                      height: 1,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('금액: ',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                              )),
                          Text(imageModel.images[0].fields[1].inferText,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                              )),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 0.3,
                      height: 1,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('인식한 정보를 확인해주세요. \n  내역을 추가하시겠습니까? ',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 10)),
                          onPressed: () {
                            savePerformance(recognizedAmount, recognizedDescp,
                                recognizedCategory);
                            Navigator.of(context).pop();
                          },
                          child: const Text('내역추가',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold)),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 10)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('취소',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                        eventLoader: _listOfDayEvents,
                      ),
                    ),
                    Offstage(
                        offstage: chartHide,
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
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
            label: '영수증 인식',
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
    final formatCurrency = NumberFormat.simpleCurrency(
        locale: 'ko_KR', name: '', decimalDigits: 0);
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
          leading: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: uploadImage.Image.asset(
                  'assets/accountimages/${performance.category}.png')),
          title:
              Text('${formatCurrency.format(num.parse(performance.amount))}원'),
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
