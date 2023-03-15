import 'package:petai_care/screens/board/pages/boardPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int current_index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: current_index,
          onTap: (index) {
            print('index test : ${index}');
            setState(() {
              current_index = index;
            });
          },
          //BottomNavi item list
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: '홈',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pets),
              label: '자가진단',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.place_outlined),
              label: '주변병원',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline),
              label: '게시판',
            ),
          ],
          selectedItemColor: Colors.grey,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
        ),
        body: Center(
          child: body_item.elementAt(current_index),
        ));
  }

  List body_item = [
    Text("홈"),
    Text("자가진단"),
    Text("주변병원"),
    BoardPage(),
  ];
}
