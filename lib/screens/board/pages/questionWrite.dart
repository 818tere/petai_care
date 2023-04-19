import 'package:cloud_firestore/cloud_firestore.dart';
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
        iconTheme: IconThemeData(color: Colors.black),
        title: const Text(
          '질문글 쓰기',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              final post = Post(
                title: controllerTitle.text,
                contents: controllerContent.text,
                writeDate: DateTime.now(),
              );
              createPost(post);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
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
                ],
              ),
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
