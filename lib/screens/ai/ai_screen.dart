import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

class AiScreen extends StatefulWidget {
  const AiScreen({super.key});

  @override
  _AiScreenState createState() => _AiScreenState();
}

class _AiScreenState extends State<AiScreen> {
  late File _imageFile;
  final picker = ImagePicker();

  _AiScreenState() {
    _imageFile = File(''); // 파일 초기화
  }

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
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://f97d-34-141-182-113.ngrok.io'),
    );
    // 이미지 파일을 요청에 추가합니다.
    request.files.add(
      await http.MultipartFile.fromPath('image', image.path),
    );
    // 요청을 보내고 응답을 받습니다.
    var response = await request.send();
    // 응답을 문자열로 변환합니다.
    var responseString = await response.stream.bytesToString();
    print(responseString);
  }

  void _sendImageToServer() {
    _uploadImage(_imageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: Padding(
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
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20.0),
          ),
          Center(
            child: _imageFile != null
                ? Image.file(
                    _imageFile,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.6,
                  )
                : const Text('선택된 사진 없음'),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () => _getImage(ImageSource.camera),
            tooltip: 'Take a photo',
            child: const Icon(Icons.add_a_photo),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () => _getImage(ImageSource.gallery),
            tooltip: 'Pick an image',
            child: const Icon(Icons.photo_library),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: _sendImageToServer,
            tooltip: 'Send image to server',
            child: const Icon(Icons.cloud_upload),
          ),
        ],
      ),
    );
  }
}
