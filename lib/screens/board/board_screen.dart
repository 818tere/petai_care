import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:petai_care/models/post.dart';
import 'package:petai_care/screens/board/pages/questionWrite.dart';
import 'package:petai_care/screens/board/pages/questionPostScreen.dart';
import 'package:petai_care/screens/board/pages/reviewPostScreen.dart';
import 'package:petai_care/screens/board/pages/reviewWrite.dart';

/// 하단의 리스트 페이지
class BoardScreen extends StatefulWidget {
  const BoardScreen({super.key});

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen>
    with SingleTickerProviderStateMixin {
  static const initialIndex = 0;
  static const tabsCount = 2;
  final tabScales =
      List.generate(tabsCount, (index) => index == initialIndex ? 1.0 : 0.0);

  late TabController tabController;

  final controllerTitle = TextEditingController();
  final controllerWriteDate = TextEditingController();
  final controllerContent = TextEditingController();

  Future<void> updateQuestion(DocumentSnapshot documentSnapshot) async {
    controllerTitle.text = documentSnapshot['title'];
    controllerContent.text = documentSnapshot['contents'];

    await showDialog(
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
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '제목을 입력해주세요.';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: controllerContent,
                        decoration: const InputDecoration(labelText: '내용'),
                        maxLines: 15,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '내용을 입력해주세요.';
                          }
                          return null;
                        },
                      ),
                      ElevatedButton(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text('Update'),
                          ),
                          onPressed: () async {
                            final String title = controllerTitle.text;
                            final String content = controllerContent.text;
                            final DateTime writeDate = DateTime.now();
                            refQuestion.doc(documentSnapshot.id).update({
                              'title': title,
                              'contents': content,
                              'writeDate': writeDate
                            });
                            controllerTitle.text = "";
                            controllerContent.text = "";
                            Navigator.of(context).pop();
                          })
                    ],
                  ),
                ),
              ),
            )));
  }

  Future<void> updateReview(DocumentSnapshot documentSnapshot) async {
    controllerTitle.text = documentSnapshot['title'];
    controllerContent.text = documentSnapshot['contents'];

    await showDialog(
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
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '제목을 입력해주세요.';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: controllerContent,
                        decoration: const InputDecoration(labelText: '내용'),
                        maxLines: 15,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '내용을 입력해주세요.';
                          }
                          return null;
                        },
                      ),
                      ElevatedButton(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text('Update'),
                          ),
                          onPressed: () async {
                            final String title = controllerTitle.text;
                            final String content = controllerContent.text;
                            final DateTime writeDate = DateTime.now();
                            refReview.doc(documentSnapshot.id).update({
                              'title': title,
                              'contents': content,
                              'writeDate': writeDate
                            });
                            controllerTitle.text = "";
                            controllerContent.text = "";
                            Navigator.of(context).pop();
                          })
                    ],
                  ),
                ),
              ),
            )));
  }

  Future<void> deleteQuestion(String questionId) async {
    await refQuestion.doc(questionId).delete();
  }

  Future<void> deleteReview(String reviewId) async {
    await refReview.doc(reviewId).delete();
  }

  CollectionReference refQuestion =
      FirebaseFirestore.instance.collection('questionPost');

  CollectionReference refReview =
      FirebaseFirestore.instance.collection('reviewPost');

  bool edit = false;
  bool delete = false;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: tabsCount,
      initialIndex: initialIndex,
      vsync: this,
    );

    tabController.animation!.addListener(() {
      setState(() {
        final animationValue = tabController.animation!.value;
        final currentTabIndex = animationValue.round();
        final currentOffset = currentTabIndex - animationValue;
        for (int i = 0; i < tabsCount; i++) {
          if (i == currentTabIndex) {
            tabScales[i] = (1.0 - currentOffset.abs());
          } else {
            tabScales[i] = 0.0;
          }
        }
      });
    });
  }

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
              icon: const Icon(Icons.edit),
              color: edit ? Colors.red : Colors.black,
              onPressed: () {
                setState(() {
                  edit = !edit;
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: delete ? Colors.red : Colors.black,
              onPressed: () {
                setState(() {
                  delete = !delete;
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
          ],
          bottom: TabBar(
              controller: tabController,
              tabs: [
                Tab(text: "질문 게시판"),
                Tab(text: "후기 게시판"),
              ],
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.black),
        ),

        body: TabBarView(
          controller: tabController,
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: refQuestion
                      .orderBy("writeDate", descending: true)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong! ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                              snapshot.data!.docs[index];
                          return Card(
                              child: ListTile(
                            title: Text(snapshot.data!.docs[index]['title']),
                            subtitle: Text(snapshot.data!.docs[index]
                                ['contents']), //userId로 변경
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Text(DateFormat('MM-dd HH:mm').format(
                                      snapshot.data!.docs[index]['writeDate']
                                          .toDate())),
                                ),
                                Visibility(
                                  visible: edit,
                                  child: IconButton(
                                    onPressed: () {
                                      updateQuestion(documentSnapshot);
                                    },
                                    padding: EdgeInsets.only(left: 5),
                                    constraints: BoxConstraints(),
                                    icon: Icon(Icons.edit),
                                  ),
                                ),
                                Visibility(
                                  visible: delete,
                                  child: IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                                title: Text('경고!'),
                                                content: Text('게시글을 삭제하시겠습니까?'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      deleteQuestion(
                                                          documentSnapshot.id);
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text('삭제'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text('취소'),
                                                  )
                                                ],
                                              ));
                                    },
                                    padding: EdgeInsets.only(left: 5),
                                    constraints: BoxConstraints(),
                                    icon: Icon(Icons.delete),
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: ((context) => QuestionPostScreen(
                                    snapshot.data!.docs[index])),
                              ));
                            },
                          ));
                        },
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return Text("there's no data");
                  }),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: refReview
                      .orderBy("writeDate", descending: true)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong! ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                              snapshot.data!.docs[index];
                          return Card(
                              child: ListTile(
                            title: Text(snapshot.data!.docs[index]['title']),
                            subtitle: Text(snapshot.data!.docs[index]
                                ['contents']), //userId로 변경
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Text(DateFormat('MM-dd HH:mm').format(
                                      snapshot.data!.docs[index]['writeDate']
                                          .toDate())),
                                ),
                                Visibility(
                                  visible: edit,
                                  child: IconButton(
                                    onPressed: () {
                                      updateReview(documentSnapshot);
                                    },
                                    padding: EdgeInsets.only(left: 5),
                                    constraints: BoxConstraints(),
                                    icon: Icon(Icons.edit),
                                  ),
                                ),
                                Visibility(
                                  visible: delete,
                                  child: IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                                title: Text('경고!'),
                                                content: Text('게시글을 삭제하시겠습니까?'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      deleteReview(
                                                          documentSnapshot.id);
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text('삭제'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text('취소'),
                                                  )
                                                ],
                                              ));
                                    },
                                    padding: EdgeInsets.only(left: 5),
                                    constraints: BoxConstraints(),
                                    icon: Icon(Icons.delete),
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: ((context) => ReviewPostScreen(
                                    snapshot.data!.docs[index])),
                              ));
                            },
                          ));
                        },
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return Text("there's no data");
                  }),
            ),
          ],
        ),
        floatingActionButton: createScaledFab(),
      ),
    );
  }

  @override
  Widget? createScaledFab() {
    final indexOfCurrentFab = tabScales.indexWhere((fabScale) => fabScale != 0);
    if (indexOfCurrentFab == -1) {
      return null;
    }

    final fab = createFab(indexOfCurrentFab);
    if (fab == null) {
      return null;
    }
    final currentFabScale = tabScales[indexOfCurrentFab];
    return Transform.scale(
      scale: currentFabScale,
      child: fab,
    );
  }

  Widget? createFab(final int index) {
    if (index == 0) {
      return FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const QuestionWrite()));
        },
        child: Icon(Icons.add),
      );
    }
    if (index == 1) {
      return FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ReviewWrite()));
        },
        child: Icon(Icons.add),
      );
    }
  }
}
