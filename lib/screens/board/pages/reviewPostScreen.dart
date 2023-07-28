import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReviewPostScreen extends StatefulWidget {
  const ReviewPostScreen(this.doc, {Key? key}) : super(key: key);
  final QueryDocumentSnapshot doc;

  @override
  State<ReviewPostScreen> createState() => _ReviewPostScreenState();
}

class _ReviewPostScreenState extends State<ReviewPostScreen> {
  final user = FirebaseAuth.instance.currentUser!;

  final controllerComment = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          '후기 게시판',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // 아이콘, userEmail, datetime
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color(0xffFFFCF3)),
                  child: Column(
                    children: [
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
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.doc["userEmail"]),
                            Text(
                              DateFormat('MM-dd HH:mm')
                                  .format(widget.doc["writeDate"].toDate()),
                            ),
                          ],
                        ),
                      ),
                      //제목
                      Container(
                        padding:
                            const EdgeInsets.only(left: 16, right: 16, top: 16),
                        width: double.infinity,
                        child: Text(
                          widget.doc["title"],
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          textScaleFactor: 1.4,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      // 내용
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 8, bottom: 8),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            widget.doc["contents"],
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                // 댓글 목록
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("reviewPost")
                      .doc(widget.doc.id)
                      .collection("reviewComments")
                      .orderBy("commentDate", descending: false)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: Text(''),
                      );
                    }
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot commentdata =
                            snapshot.data!.docs[index];
                        return GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color(0xffF3F1E4)),
                            child: ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(snapshot.data!.docs[index]['userEmail']),
                                  Text(
                                    DateFormat('MM-dd HH:mm').format(
                                      snapshot.data!.docs[index]['commentDate']
                                          .toDate(),
                                    ),
                                  )
                                ],
                              ),
                              subtitle:
                                  Text(snapshot.data!.docs[index]['comment']),
                            ),
                          ),
                          onLongPress: () {
                            showDialog(
                                context: context,
                                builder: ((context) => AlertDialog(
                                      title: const Text('경고!'),
                                      content: const Text('댓글을 삭제하시겠습니까?'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            if (snapshot.data!.docs[index]
                                                    ['userId'] ==
                                                user.uid) {
                                              FirebaseFirestore.instance
                                                  .collection('reviewPost')
                                                  .doc(widget.doc.id)
                                                  .collection('reviewComments')
                                                  .doc(commentdata.id)
                                                  .delete();
                                              Navigator.of(context).pop();
                                            } else {
                                              Navigator.of(context).pop();
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          AlertDialog(
                                                            title: const Text(
                                                                '오류!'),
                                                            content: const Text(
                                                                '작성자가 아닙니다!'),
                                                            actions: [
                                                              Center(
                                                                child:
                                                                    TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                        child: const Text(
                                                                            "확인")),
                                                              )
                                                            ],
                                                          ));
                                            }
                                          },
                                          child: const Text('삭제'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('취소'),
                                        )
                                      ],
                                    )));
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(thickness: 0);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controllerComment,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "댓글을 입력하세요",
                        hintStyle: TextStyle(color: Colors.black26),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      addComment(controllerComment.text);
                      controllerComment.clear();
                    },
                    icon: const Icon(Icons.send),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void addComment(String commentText) async {
    FocusScope.of(context).unfocus();
    await FirebaseFirestore.instance
        .collection('reviewPost')
        .doc(widget.doc.id)
        .collection('reviewComments')
        .add({
      'comment': controllerComment.text,
      'commentDate': Timestamp.now(),
      'userEmail': user.email.toString(),
      'userId': user.uid,
    });
  }
}
