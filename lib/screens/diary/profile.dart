import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  final void Function(String name, String birth, String gender, String imageUrl)
      updateProfileInfo;

  const ProfileScreen({Key? key, required this.updateProfileInfo})
      : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  File? _image;
  String _name = '';
  DateTime? _birthday;

  List<Widget> pets = <Widget>[
    const Text('강아지'),
    const Text('고양이'),
  ];
  final List<bool> _petType = [true, false]; // 초기 값은 강아지로 설정
  List<Widget> genders = <Widget>[
    const Text('수컷'),
    const Text('암컷'),
  ];
  final List<bool> _genderType = [true, false]; // 초기 값은 남자로 설정

  final _formKey = GlobalKey<FormState>();

  bool _profileExists = false;

  @override
  void initState() {
    super.initState();
    checkProfileExistence();
  }

  Future<void> checkProfileExistence() async {
    try {
      final user = _auth.currentUser;
      final docSnapshot =
          await _firestore.collection('profiles').doc(user!.uid).get();
      setState(() {
        _profileExists = docSnapshot.exists;
      });
    } catch (e) {
      print('Error checking profile existence: $e');
    }
  }

  Future<void> fetchProfileData() async {
    try {
      final user = _auth.currentUser;
      final docSnapshot =
          await _firestore.collection('profiles').doc(user!.uid).get();
      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        setState(() {
          _name = data?['name'] ?? '';
          _birthday = (data?['birthday'] as Timestamp?)?.toDate();
          _petType[0] = data?['petType'] == '강아지';
          _petType[1] = data?['petType'] == '고양이';
          _genderType[0] = data?['genderType'] == '수컷';
          _genderType[1] = data?['genderType'] == '암컷';
          // If an image exists, you can load it using the FirebaseStorage instance and the imageUrl stored in Firestore.
          // For example, if 'image' field in Firestore contains the download URL of the image:
          // final imageUrl = data['image'];
          // _image = File(await FirebaseStorage.instance.refFromURL(imageUrl).getPath());
        });
      }
    } catch (e) {
      print('Error fetching profile data: $e');
    }
  }

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      }
    });
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        final user = _auth.currentUser;
        final profileData = {
          'name': _name,
          'birthday': _birthday,
          'petType': _petType[0] ? '강아지' : '고양이',
          'genderType': _genderType[0] ? '수컷' : '암컷',
        };

        if (_image != null) {
          // 이미지 업로드 처리
          final storageRef = FirebaseStorage.instance
              .ref()
              .child('profile_images/${user!.uid}');
          await storageRef.putFile(_image!);
          final imageUrl = await storageRef.getDownloadURL();

          profileData['image'] = imageUrl;
          widget.updateProfileInfo(_name, _birthday.toString().substring(0, 10),
              _genderType[0] ? '수컷' : '암컷', imageUrl);
        }

        await _firestore.collection('profiles').doc(user!.uid).set(profileData);

        // 프로필 생성 후 다음 작업 수행
        // 예를 들면, 다음 화면으로 이동 등
      } catch (e) {
        print('프로필 생성 중 오류 발생: $e');
        // 오류 처리
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchProfileData();
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          _profileExists ? '프로필 수정' : '프로필 등록',
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: <Widget>[
          TextButton(
            onPressed: _saveProfile,
            child: Text(
              _profileExists ? '수정' : '등록',
              style: const TextStyle(fontSize: 20),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: GestureDetector(
                    onTap: _selectImage,
                    child: CircleAvatar(
                        radius: 70,
                        backgroundImage: _image != null
                            ? FileImage(_image!)
                            : const AssetImage('assets/profile.png')
                                as ImageProvider),
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  '내가 키우는 펫',
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                ),
                ToggleButtons(
                  onPressed: (int index) {
                    setState(() {
                      // The button that is tapped is set to true, and the others to false.
                      for (int i = 0; i < _petType.length; i++) {
                        _petType[i] = i == index;
                      }
                    });
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  constraints: BoxConstraints(
                      minHeight: 40.0,
                      minWidth: MediaQuery.of(context).size.width / 2 - 20),
                  isSelected: _petType,
                  children: pets,
                ),
                const SizedBox(height: 16.0),
                const Text(
                  '성별',
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                ),
                ToggleButtons(
                  onPressed: (int index) {
                    setState(() {
                      // The button that is tapped is set to true, and the others to false.
                      for (int i = 0; i < _genderType.length; i++) {
                        _genderType[i] = i == index;
                      }
                    });
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  constraints: BoxConstraints(
                      minHeight: 40.0,
                      minWidth: MediaQuery.of(context).size.width / 2 - 20),
                  isSelected: _genderType,
                  children: genders,
                ),
                const SizedBox(height: 16.0),
                const Text(
                  '나의 펫 이름',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '이름을 입력해주세요.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _name = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                const Text(
                  '태어난 날',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );

                    if (pickedDate != null) {
                      setState(() {
                        _birthday = pickedDate;
                      });
                    }
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      controller: TextEditingController(
                        text: _birthday != null
                            ? _birthday!.toString().substring(0, 10)
                            : '',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '태어난 날을 선택해주세요.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        if (value != null && value.isNotEmpty) {
                          _birthday = DateTime.parse(value);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
