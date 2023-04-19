import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String id;
  final String title;
  final String contents;
  DateTime writeDate;
  final String? userId;

  Post(
      {this.id = '',
      required this.title,
      required this.contents,
      required this.writeDate,
      this.userId});

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'contents': contents,
        'writeDate': writeDate,
        'userId': userId,
      };

  static Post fromJson(Map<String, dynamic> json) => Post(
        id: json['id'],
        title: json['title'],
        contents: json['contents'],
        userId: json['userId'],
        writeDate: (json['writeDate'] as Timestamp).toDate(),
      );
}
