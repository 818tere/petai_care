import 'package:flutter/material.dart';
import 'package:petai_care/screens/LoginSignupScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:petai_care/screens/hospital/favorite_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const PetAICare());
}

class PetAICare extends StatelessWidget {
  const PetAICare({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoriteItemProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const LoginSignupScreen(),
        theme: ThemeData(useMaterial3: true),
      ),
    );
  }
}
