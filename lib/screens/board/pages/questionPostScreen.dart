import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:petai_care/models/post.dart';
import 'package:petai_care/screens/board/board_screen.dart';
import 'package:petai_care/screens/board/pages/questionPostEdit.dart';

class QuestionPostScreen extends StatefulWidget {
  QuestionPostScreen(this.doc, {Key? key}) : super(key: key);
  QueryDocumentSnapshot doc;

  @override
  State<QuestionPostScreen> createState() => _QuestionPostScreenState();
}

class _QuestionPostScreenState extends State<QuestionPostScreen> {
  final controllerTitle = TextEditingController();
  final controllerWriteDate = TextEditingController();
  final controllerContent = TextEditingController();

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
        actions: <Widget>[
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("reviewPost")
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong! ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      controllerTitle.text = widget.doc['title'];
                      controllerContent.text = widget.doc['contents'];

                      showDialog(
                          context: context,
                          builder: (context) => Dialog(
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: <Widget>[
                                          TextFormField(
                                            controller: controllerTitle,
                                            decoration: const InputDecoration(
                                              labelText: '제목',
                                            ),
                                            textInputAction:
                                                TextInputAction.next,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return '제목을 입력해주세요.';
                                              }
                                              return null;
                                            },
                                          ),
                                          TextFormField(
                                            controller: controllerContent,
                                            decoration: const InputDecoration(
                                                labelText: '내용'),
                                            maxLines: 15,
                                            keyboardType:
                                                TextInputType.multiline,
                                            textInputAction:
                                                TextInputAction.newline,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return '내용을 입력해주세요.';
                                              }
                                              return null;
                                            },
                                          ),
                                          ElevatedButton(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Text('Update'),
                                              ),
                                              onPressed: () async {
                                                final String title =
                                                    controllerTitle.text;
                                              })
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ));
                    },
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                return Text("there's no data");
              }),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
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
              DateFormat('MM-dd HH:mm')
                  .format(widget.doc["writeDate"].toDate()),
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
      ),
    );
  }
}
