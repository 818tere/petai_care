import 'dart:ui';

import 'package:flutter/material.dart';

class SelectMenu extends StatelessWidget {
  final String imageName;
  final String title;

  const SelectMenu(this.imageName, this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20), // 세로 간격 20으로
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 2/1, // 이미지사이즈 크기를 조정 2/1 -> 2배 줄임
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30), // 모서리 라운딩 처리
                child: Center(
                  child: Container(
                    child: Image.asset( // 이미지 지정, 인자값으로 받은 이미지명을 assets에서 찾아 가져옴
                      "assets/images/$imageName.jpeg",
                      fit: BoxFit.cover, // 이미지 맞춤을 커버 형식으로
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 5,), // 이미지와 아래 text 간격
            Text(
              title,
              style: TextStyle(fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }
}