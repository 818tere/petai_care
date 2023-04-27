import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class QuestionPostScreen extends StatefulWidget {
  const QuestionPostScreen(this.doc, {Key? key}) : super(key: key);
  final QueryDocumentSnapshot doc;

  @override
  State<QuestionPostScreen> createState() => _QuestionPostScreenState();
}

class _QuestionPostScreenState extends State<QuestionPostScreen> {
  final user = FirebaseAuth.instance.currentUser!;

  CollectionReference refComment =
      FirebaseFirestore.instance.collection('comments');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          widget.doc["title"],
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
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
          // 아이콘, userEmail, datetime
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
            title: Text(widget.doc["userEmail"]),
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
            padding:
                const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
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
                      Expanded(
                        child: TextFormField(
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
                          ),
                          onChanged: (value) {
                            setState(() {
                              userEnterComment = value;
                            });
                          },
                        ),
                      ),
                      IconButton(
                        onPressed:
                            userEnterComment.trim().isEmpty ? null : addComment,
                        icon: const Icon(Icons.send),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  var userEnterComment = '';
  Future<void> addComment() async {
    FocusScope.of(context).unfocus();
    await FirebaseFirestore.instance
        .collection('questionPost')
        .doc('TBeYcau11sYoHMTSPfF9')
        .collection('comments')
        .add({'comment': userEnterComment});
  }

  addComment1(Map<String, dynamic> comments, String id) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('questionPost');
    users.doc(id).collection('comments').add(comments);
  }
}
