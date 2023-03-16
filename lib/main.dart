import 'package:flutter/material.dart';
import 'package:petai_care/screens/LoginSignupScreen.dart';
import 'package:petai_care/theme.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const PetAICare());
}

class PetAICare extends StatelessWidget {
  const PetAICare({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet_AI_Care',
      debugShowCheckedModeBanner: false,
      home: const LoginSignupScreen(),
      theme: theme(),
    );
  }
}
