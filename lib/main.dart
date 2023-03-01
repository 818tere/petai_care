import 'package:flutter/material.dart';
import 'package:petai_care/screens/main_screens.dart';
import 'package:petai_care/theme.dart';

void main() {
  runApp(const PetAICare());
}

class PetAICare extends StatelessWidget {
  const PetAICare({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet_AI_Care',
      debugShowCheckedModeBanner: false,
      home: const MainScreens(),
      theme: theme(),
    );
  }
}
