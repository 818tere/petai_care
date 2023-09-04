import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:petai_care/screens/diary/profile.dart';
import 'package:petai_care/screens/diary/vaccine.dart';

class DrawerBar extends StatefulWidget {
  const DrawerBar({Key? key}) : super(key: key);

  @override
  _DrawerBarState createState() => _DrawerBarState();
}

class _DrawerBarState extends State<DrawerBar> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? accountName;
  String? accountEmail;
  String? profileImageUrl;
  String? profileGender;
  String? age;
  String? dDay;

  void updateProfileInfo(
      String name, String birth, String gender, String imageUrl) {
    setState(() {
      accountName = name;
      accountEmail = birth;
      profileImageUrl = imageUrl;
      profileGender = gender;
    });
  }

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
      final profileData = await FirebaseFirestore.instance
          .collection('profiles')
          .doc(user!.uid)
          .get();
      if (profileData.exists) {
        final name = profileData['name'];
        final birthdayTimestamp = profileData['birthday'] as Timestamp?;
        final birthday = birthdayTimestamp?.toDate();
        final gender = profileData['genderType'];
        final image = profileData['image'];

        if (birthday != null) {
          // Calculate age
          final ageDuration = DateTime.now().difference(birthday);
          final ageYears = ageDuration.inDays ~/ 365;
          age = '$ageYears세';

          // Calculate D-day
          final today = DateTime.now();
          final dDayDuration = birthday.difference(today);
          final dDayDays = dDayDuration.inDays;
          dDay = dDayDays >= 0 ? 'D-$dDayDays' : 'D+${dDayDays.abs()}';
        }

        setState(() {
          accountName = name;
          accountEmail = birthday != null ? formatDate(birthday) : '';
          profileImageUrl = image;
          profileGender = gender;
        });
      }
    }
  }

  String formatDate(DateTime dateTime) {
    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.08,
        ),
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: profileImageUrl != null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(profileImageUrl!),
                      radius: 40,
                    )
                  : const Icon(
                      Icons.pets,
                      size: 40,
                    ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  accountName ?? '',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                if (age != null && dDay != null)
                  Text(
                    '$age ($dDay)',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                  ),
              ],
            ),
          ],
        ),
        ListTile(
          leading: Icon(
            Icons.vaccines,
            color: Colors.grey[850],
          ),
          title: const Text('예방접종 기록/확인', style: TextStyle(fontSize: 16)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const VaccineScreen()),
            );
          },
        ),
        ListTile(
          leading: Icon(
            Icons.settings,
            color: Colors.grey[850],
          ),
          title: const Text('정보등록/수정', style: TextStyle(fontSize: 16)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileScreen(
                  updateProfileInfo: updateProfileInfo,
                ),
              ),
            );
          },
        ),
        ListTile(
          leading: Icon(
            Icons.logout,
            color: Colors.grey[850],
          ),
          title: const Text('로그아웃', style: TextStyle(fontSize: 16)),
          onTap: () {
            _auth.signOut();
            Navigator.popUntil(
                context, ModalRoute.withName(Navigator.defaultRouteName));
          },
        ),
      ]),
    );
  }
}
