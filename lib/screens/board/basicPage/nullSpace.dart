import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NullSpace extends StatelessWidget {
  const NullSpace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:40),
      child: Text(
        "",
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}