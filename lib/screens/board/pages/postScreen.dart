import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('index'),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
      ),
      body: Column(children: [
        // 아이콘, 익명, datetime
        ListTile(
          leading: const CircleAvatar(
            backgroundColor: Colors.white,
            child: CircleAvatar(
              backgroundColor: Color(0xffE6E6E6),
              child: Icon(
                Icons.person,
                color: Color(0xffCCCCCC),
              ),
            ),
          ),
          title: const Text('익명'),
          subtitle: Text(DateFormat.yMMMd().format(DateTime.now())),
        ),
        // 제목
        Container(
          padding: const EdgeInsets.all(8),
          width: double.infinity,
          child: const Text(
            'post.title!',
            style: TextStyle(fontWeight: FontWeight.bold),
            textScaleFactor: 1.4,
            textAlign: TextAlign.start,
          ),
        ),
        // 내용
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text('post.contents!'),
          ),
        ),
        const SizedBox(
          height: 1,
        ),
        const Divider(
          thickness: 1,
        ),
        // 댓글 목록
        const Center(
          child: Text('No comments'),
        ),
        const SizedBox(
          height: 100,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Flexible(
                    child: Container(
                      child: Form(
                        child: TextFormField(
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return '댓글을 입력하세요.';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            hintText: "댓글을 입력하세요.",
                            hintStyle: const TextStyle(color: Colors.black26),
                            isDense: true,
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      print('input comment: ');
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
