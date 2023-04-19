import 'result_list.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

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
    var url = Uri.parse('http://f153-35-222-123-163.ngrok-free.app');
    var request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath('file', image.path));
    var response = await request.send();
    var responseString = await response.stream.bytesToString();
    String koreanString = jsonDecode(
      const Utf8Decoder().convert(responseString.runes.toList()),
    )['class_name'];

    if (!mounted) return;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('질병 코드'),
        content: Text(koreanString),
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.receipt_long),
                iconSize: 250.0,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ResultListScreen()),
                  );
                },
              ),
              const Text(
                '진단 결과 목록',
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
            ],
          )
        ],
      ),
      floatingActionButton: Column(
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
      ),
    );
  }
}
