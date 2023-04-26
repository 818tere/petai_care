import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String id;
  final String title;
  final String contents;
  DateTime writeDate;
  final String userId;
  final String userEmail;

  Post(
      {this.id = '',
      required this.title,
      required this.contents,
      required this.writeDate,
      required this.userId,
      required this.userEmail});

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'contents': contents,
        'writeDate': writeDate,
        'userId': userId,
        'userEmail': userEmail,
      };

  static Post fromJson(Map<String, dynamic> json) => Post(
        id: json['id'],
        title: json['title'],
        contents: json['contents'],
        userId: json['userId'],
        userEmail: json['userEmail'],
        writeDate: (json['writeDate'] as Timestamp).toDate(),
      );
}
