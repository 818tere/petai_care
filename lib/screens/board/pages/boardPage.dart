import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petai_care/screens/board/pages/boardQuestion.dart';
import 'package:petai_care/screens/board/pages/boardReview.dart';
import '../basicPage/nullSpace.dart';
import '../basicPage/selectMenu.dart';

/**
 * 하단의 리스트 페이지
 */
class BoardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 배경색 지정
      appBar: _buildBoardAppBar(), // AppBar 연결
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20), // 수평으로 여백 주기
        child: ListView(
          // Column 위에서 아래로 내려가는 구조
          children: [
            NullSpace(),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BoardQuestion()),
                  );
                },
                child: Container(child: SelectMenu("question", "질문 게시판"))),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BoardReview()),
                  );
                },
                child: Container(child: SelectMenu("review", "후기 게시판"))),
          ],
        ),
      ),
    );
  }
}

/**
 * 상단의 앱 바
 */
AppBar _buildBoardAppBar() {
  return AppBar(
    title: Text(
      "게시판",
      style: TextStyle(color: Colors.white),
    ),
    centerTitle: true,
    backgroundColor: Colors.orangeAccent, //배경색
    elevation: 3.0, // 그림자 효과 조정
  );
}
