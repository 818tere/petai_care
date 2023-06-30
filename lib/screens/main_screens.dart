import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:petai_care/screens/account/account_screen.dart';
import 'package:petai_care/screens/ai/ai_screen.dart';
import 'package:petai_care/screens/board/board_screen.dart';
import 'package:petai_care/screens/diary/diary_screen.dart';
import 'package:petai_care/screens/account/firestore.dart';
import 'package:petai_care/screens/hospital/myfavorite.dart';
import 'package:petai_care/screens/hospital/quick_search.dart';

class MainScreens extends StatefulWidget {
  const MainScreens({Key? key}) : super(key: key);

  @override
  _MainScreensState createState() => _MainScreensState();
}

class _MainScreensState extends State<MainScreens> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int _selectedIndex = 0;
  String? accountName;
  String? accountEmail;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      await user.reload();
      user = _auth.currentUser;
      setState(() {
        accountName = user?.displayName ?? '';
        accountEmail = user?.email ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              _auth.signOut();
              Navigator.pop(context);
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.favorite_outline_outlined,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyFavoriteItemScreen(),
                ),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              color: Colors.blue.shade200,
            ),
            accountName: Text(accountName ?? ''),
            accountEmail: Text(
              accountEmail ?? '',
              style: const TextStyle(fontSize: 20, color: Colors.black),
            ),
            currentAccountPicture: const Icon(
              Icons.pets,
              size: 60,
            ),
          ),
          ListTile(
            title: const Text('정보등록'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const DiaryScreen()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.grey[850],
            ),
            title: const Text('로그아웃'),
            onTap: () {
              _auth.signOut();
              Navigator.popUntil(
                  context, ModalRoute.withName(Navigator.defaultRouteName));
            },
          ),
        ]),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          AiScreen(),
          QuickSearch(),
          FireStore(),
          BoardScreen(),
          AccountScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              label: '자가진단', icon: Icon(CupertinoIcons.bandage)),
          BottomNavigationBarItem(
              label: '동물병원', icon: Icon(CupertinoIcons.placemark)),
          BottomNavigationBarItem(
              label: '가계부', icon: Icon(CupertinoIcons.creditcard)),
          BottomNavigationBarItem(
              label: '게시판', icon: Icon(CupertinoIcons.bubble_left)),
          BottomNavigationBarItem(
              label: '테스트', icon: Icon(CupertinoIcons.bubble_left)),
        ],
      ),
    );
  }
}
