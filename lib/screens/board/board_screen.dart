import 'package:flutter/material.dart';
import 'package:petai_care/screens/board/pages/boardWrite.dart';
import 'package:petai_care/screens/board/pages/postScreen.dart';

/// 하단의 리스트 페이지
class BoardScreen extends StatefulWidget {
  const BoardScreen({super.key});

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
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          automaticallyImplyLeading: false,
          title: const Padding(
            padding: EdgeInsets.only(left: 12),
            child: Text(
              "게시판",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BoardWrite()),
                );
              },
            ),
          ],
          bottom: const TabBar(tabs: [
            Tab(text: "질문 게시판"),
            Tab(text: "후기 게시판"),
          ], labelColor: Colors.blue, unselectedLabelColor: Colors.black),
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
                          MaterialPageRoute(
                              builder: (context) => const PostScreen()),
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
                          MaterialPageRoute(
                              builder: (context) => const PostScreen()),
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
