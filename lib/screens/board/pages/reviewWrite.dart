import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petai_care/models/post.dart';

class ReviewWrite extends StatefulWidget {
  const ReviewWrite({super.key});

  @override
  State<ReviewWrite> createState() => _ReviewWriteState();
}

class _ReviewWriteState extends State<ReviewWrite> {
  final controllerTitle = TextEditingController();
  final controllerWriteDate = TextEditingController();
  final controllerContent = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          '후기글 쓰기',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.check),
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
  final docPost = FirebaseFirestore.instance.collection('reviewPost').doc();
  post.id = docPost.id;
  post.writeDate = DateTime.now();

  final json = post.toJson();
  await docPost.set(json);
}
