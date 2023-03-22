import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:petai_care/screens/account/account_screen.dart';
import 'package:petai_care/screens/ai/ai_screen.dart';
import 'package:petai_care/screens/board/board_screen.dart';
import 'package:petai_care/screens/hospital/hospital_screen.dart';

class MainScreens extends StatefulWidget {
  const MainScreens({super.key});

  @override
  _MainScreensState createState() => _MainScreensState();
}

class _MainScreensState extends State<MainScreens> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              _auth.signOut();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          AiScreen(),
          const HospitalScreen(),
          const AccountScreen(),
          BoardScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              label: '자가진단', icon: Icon(CupertinoIcons.bandage)),
          BottomNavigationBarItem(
              label: '동물병원', icon: Icon(CupertinoIcons.placemark)),
          BottomNavigationBarItem(
              label: '가계부', icon: Icon(CupertinoIcons.creditcard)),
          BottomNavigationBarItem(
              label: '게시판', icon: Icon(CupertinoIcons.bubble_left)),
        ],
      ),
    );
  }
}
