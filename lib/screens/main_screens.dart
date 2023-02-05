import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petai_care/screens/account/account_screen.dart';
import 'package:petai_care/screens/ai/ai_screen.dart';
import 'package:petai_care/screens/board/board_screen.dart';
import 'package:petai_care/screens/diary/diary_screen.dart';
import 'package:petai_care/screens/home/home_screen.dart';
import 'package:petai_care/screens/hospital/hospital_screen.dart';

class MainScreens extends StatefulWidget {
  @override
  _MainScreensState createState() => _MainScreensState();
}

class _MainScreensState extends State<MainScreens> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomeScreen(),
          AiScreen(),
          BoardScreen(),
          HospitalScreen(),
          AccountScreen(),
          DiaryScreen()
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
        items: [
          const BottomNavigationBarItem(
              label: '홈', icon: Icon(CupertinoIcons.home)),
          const BottomNavigationBarItem(
              label: '자가진단', icon: Icon(CupertinoIcons.square_on_square)),
          const BottomNavigationBarItem(
              label: '주변병원', icon: Icon(CupertinoIcons.placemark)),
          const BottomNavigationBarItem(
              label: '가계부', icon: Icon(CupertinoIcons.square_on_square))
        ],
      ),
    );
  }
}
