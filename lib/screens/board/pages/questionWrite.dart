import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petai_care/models/post.dart';

class QuestionWrite extends StatefulWidget {
  const QuestionWrite({super.key});

  @override
  State<QuestionWrite> createState() => _QuestionWriteState();
}

class _QuestionWriteState extends State<QuestionWrite> {
  final controllerTitle = TextEditingController();
  final controllerWriteDate = TextEditingController();
  final controllerContent = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          '질문글 쓰기',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: <Widget>[
          TextButton(
              onPressed: () {
                final user = FirebaseAuth.instance.currentUser!;
                final post = Post(
                  title: controllerTitle.text,
                  contents: controllerContent.text,
                  userId: user.uid,
                  userEmail: user.email.toString(),
                  writeDate: DateTime.now(),
                );
                createPost(post);
                Navigator.pop(context);
              },
              child: const Text('등록', style: TextStyle(fontSize: 20))),
        ],
      ),
      body: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('제목',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey.shade200),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: TextFormField(
                      controller: controllerTitle,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '제목을 입력해주세요.';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('내용',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey.shade200),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: TextFormField(
                      controller: controllerContent,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future createPost(Post post) async {
  final docPost = FirebaseFirestore.instance.collection('questionPost').doc();
  post.id = docPost.id;
  post.writeDate = DateTime.now();

  final json = post.toJson();
  await docPost.set(json);
}
