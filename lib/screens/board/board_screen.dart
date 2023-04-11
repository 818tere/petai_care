import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:petai_care/models/post.dart';
import 'package:petai_care/screens/board/pages/postList.dart';
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
                  stream: FirebaseFirestore.instance
                      .collection("questionPost")
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong! ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      return ListView(
                        children: snapshot.data!.docs
                            .map((post) => postList(() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            QuestionPostScreen(post),
                                      ));
                                }, post))
                            .toList(),
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
                  stream: FirebaseFirestore.instance
                      .collection("reviewPost")
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong! ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      return ListView(
                        children: snapshot.data!.docs
                            .map((post) => postList(() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ReviewPostScreen(post),
                                      ));
                                }, post))
                            .toList(),
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

  Stream<List<Post>> readQuestionPost() => FirebaseFirestore.instance
      .collection('questionPost')
      .orderBy('writeDate', descending: true)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Post.fromJson(doc.data())).toList());

  Stream<List<Post>> readReviewPost() => FirebaseFirestore.instance
      .collection('reviewPost')
      .orderBy('writeDate', descending: true)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Post.fromJson(doc.data())).toList());

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
        child: Icon(Icons.edit),
      );
    }
    if (index == 1) {
      return FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ReviewWrite()));
        },
        child: Icon(Icons.edit),
      );
    }
  }
}
