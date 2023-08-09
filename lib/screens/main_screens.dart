import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:petai_care/screens/account/account_screen.dart';
import 'package:petai_care/screens/ai/ai_screen.dart';
import 'package:petai_care/screens/board/board_screen.dart';
import 'package:petai_care/screens/account/firestore.dart';
import 'package:petai_care/screens/diary/drawerbar.dart';
import 'package:petai_care/screens/hospital/quick_search.dart';

class MainScreens extends StatefulWidget {
  const MainScreens({Key? key}) : super(key: key);

  @override
  _MainScreensState createState() => _MainScreensState();
}

class _MainScreensState extends State<MainScreens> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      drawer: const DrawerBar(),
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          AiScreen(),
          QuickSearch(),
          FireStore(),
          BoardScreen(),
          AccountScreen(),
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
          BottomNavigationBarItem(
              label: '테스트', icon: Icon(CupertinoIcons.bubble_left)),
        ],
      ),
    );
  }
}
