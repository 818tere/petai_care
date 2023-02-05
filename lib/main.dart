import 'package:flutter/material.dart';
import 'package:petai_care/screens/main_screens.dart';
import 'package:petai_care/theme.dart';

void main() {
  runApp(PetAICare());
}

class PetAICare extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet_AI_Care',
      debugShowCheckedModeBanner: false,
      home: MainScreens(),
      theme: theme(),
    );
  }
}

