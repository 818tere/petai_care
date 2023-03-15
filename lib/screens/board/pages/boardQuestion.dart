import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petai_care/screens/board/pages/boardWrite.dart';
import 'package:petai_care/screens/board/pages/postScreen.dart';

class BoardQuestion extends StatelessWidget {
  const BoardQuestion({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('질문 게시판'),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
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
      ),
      body: ListView.builder(
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
