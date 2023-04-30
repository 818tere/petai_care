import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'package:petai_care/screens/ai/result_list.dart';

final manualList = [
  Image.asset('assets/images/question.jpeg', fit: BoxFit.cover),
  Image.asset('assets/images/review.jpeg', fit: BoxFit.cover),
]; // 초기화면 매뉴얼 슬라이드 리스트

class AiScreen extends StatefulWidget {
  const AiScreen({super.key});

  @override
  State<AiScreen> createState() => _AiScreenState();
}

class _AiScreenState extends State<AiScreen> {
  late File _imageFile;
  final picker = ImagePicker();

  _AiScreenState() {
    _imageFile = File(''); // 파일 초기화
  }
  bool isLoaing = false; //로딩화면

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _uploadImage(File image) async {
    // 주소 변경해야 함
    var url = Uri.parse('http://11ea-34-91-97-125.ngrok-free.app');
    var request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath('file', image.path));
    var response = await request.send();
    var responseString = await response.stream.bytesToString();
    String koreanString = jsonDecode(
      const Utf8Decoder().convert(responseString.runes.toList()),
    )['class_name'];
    int prob = jsonDecode(
      const Utf8Decoder().convert(responseString.runes.toList()),
    )['probability'];

    if (!mounted) return;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('진단 결과'),
        content: Text("$koreanString 확률: $prob%"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _sendImageToServer() {
    _uploadImage(_imageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Theme(
        data: Theme.of(context).copyWith(
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            extendedSizeConstraints: BoxConstraints.tightFor(
                width: (MediaQuery.of(context).size.width * 0.5) - 20,
                height: MediaQuery.of(context).size.height * 0.2),
          ),
        ),
        child: Wrap(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: const [
                    //_buildManualList(),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.receipt_long),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ResultListScreen()),
                        );
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: FloatingActionButton.extended(
                        //extendedIconLabelSpacing: 16,
                        //extendedPadding: EdgeInsets.all(8),
                        backgroundColor: Colors.blue.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        icon: const Icon(Icons.eco, size: 100),
                        label: const Text('강아지 피부질환'),
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: FloatingActionButton.extended(
                        //extendedIconLabelSpacing: 16,
                        //extendedPadding: EdgeInsets.all(8),
                        backgroundColor: Colors.blue.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        icon: const Icon(Icons.eco, size: 100),
                        label: const Text('강아지 피부질환'),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: FloatingActionButton.extended(
                        //extendedIconLabelSpacing: 16,
                        //extendedPadding: EdgeInsets.all(8),
                        backgroundColor: Colors.blue.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        icon: const Icon(Icons.eco, size: 100),
                        label: const Text('강아지 피부질환'),
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: FloatingActionButton.extended(
                        //extendedIconLabelSpacing: 16,
                        //extendedPadding: EdgeInsets.all(8),
                        backgroundColor: Colors.blue.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        icon: const Icon(Icons.eco, size: 100),
                        label: const Text('강아지 피부질환'),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Row(
              children: const [
                Text(
                  '자가진단',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
      /*floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: 'a1',
            onPressed: () => _getImage(ImageSource.camera),
            tooltip: 'Take a photo',
            child: const Icon(Icons.add_a_photo),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: 'a2',
            onPressed: () => _getImage(ImageSource.gallery),
            tooltip: 'Pick an image',
            child: const Icon(Icons.photo_library),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: 'a3',
            onPressed: _sendImageToServer,
            tooltip: 'Send image to server',
            child: const Icon(Icons.cloud_upload),
          ),
        ],
      ),*/
    );
  }

  /*Widget _buildManualList() {
    return CarouselSlider(
      options: CarouselOptions(
          height: MediaQuery.of(context).size.height * 0.2, autoPlay: true),
      items: manualList.map((image) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: image,
              ),
            );
          },
        );
      }).toList(),
    );
  }*/
}
