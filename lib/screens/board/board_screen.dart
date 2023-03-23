import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petai_care/screens/board/pages/boardWrite.dart';
import 'package:petai_care/screens/board/pages/postScreen.dart';
import 'basicPage/nullSpace.dart';
import 'basicPage/selectMenu.dart';

/**
 * 하단의 리스트 페이지
 */
class BoardScreen extends StatefulWidget {
  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white, // 배경색 지정
        appBar: AppBar(
          title: Text(
            "게시판",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.orange,
          centerTitle: true,
          elevation: 3.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BoardWrite()),
                );
              },
            ),
          ],
          bottom: TabBar(tabs: [
            Tab(text: "질문 게시판"),
            Tab(text: "후기 게시판"),
          ], labelColor: Colors.white, unselectedLabelColor: Colors.black),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
                itemCount: 15,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Text('$index번째 질문'),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PostScreen()),
                        );
                      },
                    ),
                  );
                }),
            ListView.builder(
                itemCount: 15,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Text('$index번째 후기'),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PostScreen()),
                        );
                      },
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

Widget questionList() {
  final items = List.generate(15, (i) {
    var num = i + 1;
    return ListTile(
      title: Text('$num번째 질문'),
    );
  });

  return ListView(
    children: items,
  );
}
