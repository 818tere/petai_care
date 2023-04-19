import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget postList(Function()? onTap, QueryDocumentSnapshot doc) {
  return InkWell(
      onTap: onTap,
      child: Card(
          child: ListTile(
        title: Text(doc["title"]),
        subtitle: Text(doc["contents"]), //userId로 변경
        trailing:
            Text(DateFormat('MM-dd HH:mm').format(doc["writeDate"].toDate())),
      )));
}
