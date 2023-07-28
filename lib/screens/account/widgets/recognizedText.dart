import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petai_care/screens/account/models/image_model.dart';
import 'package:flutter/src/widgets/image.dart' as uploadImage;

class RecognizedTextScreen extends StatelessWidget {
  final XFile image;
  final ImageModel imageModel;
  final CollectionReference<Object?> items;
  final CollectionReference<Object?> markers;
  final DateTime selectedDay;
  final Map<DateTime, List<dynamic>> calendarMarker;

  const RecognizedTextScreen({
    super.key,
    required this.image,
    required this.imageModel,
    required this.items,
    required this.markers,
    required this.selectedDay,
    required this.calendarMarker,
  });

  @override
  Widget build(BuildContext context) {
    String amountTemp = (imageModel.images[0].fields[1].inferText)
        .replaceAll(RegExp('[^0-9\\s]'), '');
    String recognizedAmount = amountTemp;
    String recognizedDescp = imageModel.images[0].fields[0].inferText;
    String recognizedCategory = recognizedDescp.contains('병원') ? '병원비' : '양육비';

    return Scaffold(
      bottomSheet: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: const BoxDecoration(
          color: Color(0xffE8DEF8),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('인식한 정보를 확인해주세요. \n  내역을 추가하시겠습니까? ',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                    ))
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                      Size(MediaQuery.of(context).size.width * 0.4, 50),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xffEADDFF)),
                  ),
                  onPressed: () async {
                    await items.add({
                      'amount': recognizedAmount,
                      'descp': recognizedDescp,
                      'category': recognizedCategory,
                      'date': selectedDay.toString(),
                    });
                    await markers.add({
                      'amount': recognizedAmount,
                      'descp': recognizedDescp,
                      'date': selectedDay.toString(),
                    });
                    if (calendarMarker[
                            DateTime.parse(selectedDay.toString())] !=
                        null) {
                      calendarMarker[DateTime.parse(selectedDay.toString())]
                          ?.add({
                        'amount': recognizedAmount,
                        'descp': recognizedDescp,
                        'date': selectedDay.toString(),
                      });
                    } else {
                      calendarMarker[DateTime.parse(selectedDay.toString())] = [
                        {
                          'amount': recognizedAmount,
                          'descp': recognizedDescp,
                          'date': selectedDay.toString(),
                        }
                      ];
                    }
                    Navigator.of(context).pop();
                  },
                  child: const Text('추가하기', style: TextStyle(fontSize: 16)),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                      Size(MediaQuery.of(context).size.width * 0.4, 50),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xffEADDFF)),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('취소', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ],
        ),
      ),
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
                height: MediaQuery.of(context).size.height * 0.45,
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
                          const Text(
                            '사업자명: ',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                            ),
                          ),
                          Text(
                            imageModel.images[0].fields[0].inferText,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                            ),
                          ),
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
                          Text(
                            imageModel.images[0].fields[1].inferText,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                            ),
                          ),
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
            ],
          ),
        ),
      ),
    );
  }
}
