import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResultListScreen extends StatefulWidget {
  const ResultListScreen({super.key});

  @override
  State<ResultListScreen> createState() => _ResultListScreenState();
}

class _ResultListScreenState extends State<ResultListScreen> {
  User user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('진단결과목록'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('diagnostic')
            .doc(user.uid)
            .collection('ai_result')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data!.docs[index];
              return ListTile(
                title: Row(
                  children: [
                    Text(ds['name'],
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 10),
                    Text(ds['percentage'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red
                        )),
                  ],
                ),
                subtitle: Row(
                  children: [
                    Text(ds['date'], style: const TextStyle(fontSize: 15)),
                  ],
                ),
                trailing: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: const Text("이 항목을 삭제하시겠습니까?",
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.center),
                          actions: <Widget>[
                            TextButton(
                              child: const Text("취소"),
                              onPressed: () {
                                Navigator.of(context).pop(); // 다이얼로그 닫기
                              },
                            ),
                            TextButton(
                              child: const Text("삭제"),
                              onPressed: () async {
                                Navigator.of(context).pop();

                                await FirebaseFirestore.instance
                                    .collection('diagnostic')
                                    .doc(user.uid)
                                    .collection('ai_result')
                                    .doc(ds.id)
                                    .delete();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.more_vert),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
