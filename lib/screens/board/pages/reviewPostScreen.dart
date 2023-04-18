import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:petai_care/models/post.dart';
import 'package:petai_care/screens/board/board_screen.dart';

class ReviewPostScreen extends StatefulWidget {
  ReviewPostScreen(this.doc, {Key? key}) : super(key: key);
  QueryDocumentSnapshot doc;

  @override
  State<ReviewPostScreen> createState() => _ReviewPostScreenState();
}

class _ReviewPostScreenState extends State<ReviewPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          widget.doc["title"],
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(children: [
        //제목
        Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          width: double.infinity,
          child: Text(
            widget.doc["title"],
            style: const TextStyle(fontWeight: FontWeight.bold),
            textScaleFactor: 1.4,
            textAlign: TextAlign.start,
          ),
        ),
        // 아이콘, 익명, datetime
        ListTile(
          leading: CircleAvatar(
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
          subtitle: Text(
            DateFormat('MM-dd HH:mm').format(widget.doc["writeDate"].toDate()),
          ),
        ),
        const Divider(
          thickness: 1,
        ),
        // 내용
        Padding(
          padding: EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(widget.doc["contents"]),
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
              child: SingleChildScrollView(
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
        ),
      ]),
    );
  }
}
