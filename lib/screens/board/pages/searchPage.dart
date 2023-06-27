import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  final controllerSearch = TextEditingController();
  List postList = [];
  getClientStream() async {
    var data = await FirebaseFirestore.instance
        .collection('questionPost')
        .orderBy("writeDate", descending: true)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // The search area here
          title: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: TextFormField(
            controller: controllerSearch,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  controllerSearch.clear();
                },
              ),
              hintText: 'Search',
            ),
          ),
        ),
      )),
    );
  }
}
