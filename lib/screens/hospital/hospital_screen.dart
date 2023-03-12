import 'package:flutter/cupertino.dart';
import 'package:petai_care/screens/hospital/seoul_guro.dart';
import 'package:flutter/material.dart';



class HospitalScreen extends StatelessWidget {
  const HospitalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('병원 검색'),
        centerTitle: true,
        elevation: 0.0,
        actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.favorite_border), 
          onPressed: () { 
            debugPrint('favoite border is clicke12321312d');
           },
        ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage('assets/dog1.png'),
                backgroundColor: Colors.white,
              ),
              otherAccountsPictures: const<Widget>[
                CircleAvatar(
                  backgroundImage: AssetImage('assets/dog2.gif'),
                  backgroundColor: Colors.white,
                ),
              ],
              accountName: const Text('이동영'),
              accountEmail: const Text('ldy2889@gmail.com'),
              onDetailsPressed:(){
                debugPrint('arrow is clicked');
              },
              decoration: BoxDecoration(
                color: Colors.orange[200],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                bottomRight: Radius.circular(40.0))
              ),
              ),
              ListTile(
                leading: Icon(Icons.home,
                color: Colors.grey[850],
                ),
                title: const Text('Home'),
                onTap: (){
                  debugPrint('Home is clicked');
                },
                trailing: const Icon(Icons.add),
              ),
              ListTile(
                leading: Icon(Icons.settings,
                color: Colors.grey[850],
                ),
                title: const Text('Settings'),
                onTap: (){
                  debugPrint('Settings is clicked');
                },
                trailing: const Icon(Icons.add),
              ),
              ListTile(
                leading: Icon(Icons.question_answer,
                color: Colors.grey[850],
                ),
                title: const Text('QnA'),
                onTap: (){
                  debugPrint('QnA is clicked');
                },
                trailing: const Icon(Icons.add),
              ),
          ],
        ),
      ),
      
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
            Container(
              width: 150.0,
              height: 50,
            child:ElevatedButton(
              // 버튼 누르면 페이지 이동
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Seoul()));
              },
            child: Text('서 울',
            style: TextStyle(fontSize: 20, color: Colors.white),),
            style: ElevatedButton.styleFrom(
              primary: Colors.orangeAccent,
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              elevation: 5.0
            ),
            ),
            ),
            Container(
              width: 150.0,
              height: 50,
            child:ElevatedButton(
              // 버튼 누르면 페이지 이동
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Seoul()));
              },
            child: Text('경 기',
            style: TextStyle(fontSize: 20, color: Colors.white),),
            style: ElevatedButton.styleFrom(
              primary: Colors.orangeAccent,
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              elevation: 5.0
            ),
            ),
            
            ),
          ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
            Container(
              width: 150.0,
              height: 50,
            child:ElevatedButton(
              // 버튼 누르면 페이지 이동
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Seoul()));
              },
            child: Text('부 산',
            style: TextStyle(fontSize: 20, color: Colors.white),),
            style: ElevatedButton.styleFrom(
              primary: Colors.orangeAccent,
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              elevation: 5.0
            ),
            ),
            ),
            Container(
              width: 150.0,
              height: 50,
            child:ElevatedButton(
              // 버튼 누르면 페이지 이동
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Seoul()));
              },
            child: Text('경 남',
            style: TextStyle(fontSize: 20, color: Colors.white),),
            style: ElevatedButton.styleFrom(
              primary: Colors.orangeAccent,
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              elevation: 5.0
            ),
            ),
            
            ),
          ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
            Container(
              width: 150.0,
              height: 45,
            child:ElevatedButton(
              // 버튼 누르면 페이지 이동
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Seoul()));
              },
            child: Text('인 천',
            style: TextStyle(fontSize: 20, color: Colors.white),),
            style: ElevatedButton.styleFrom(
              primary: Colors.orangeAccent,
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              elevation: 5.0
            ),
            ),
            ),
            Container(
              width: 150.0,
              height: 50,
            child:ElevatedButton(
              // 버튼 누르면 페이지 이동
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Seoul()));
              },
            child: Text('경 북',
            style: TextStyle(fontSize: 20, color: Colors.white),),
            style: ElevatedButton.styleFrom(
              primary: Colors.orangeAccent,
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              elevation: 5.0
            ),
            ),
            
            ),
          ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
            Container(
              width: 150.0,
              height: 50,
            child:ElevatedButton(
              // 버튼 누르면 페이지 이동
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Seoul()));
              },
            child: Text('대 구',
            style: TextStyle(fontSize: 20, color: Colors.white),),
            style: ElevatedButton.styleFrom(
              primary: Colors.orangeAccent,
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              elevation: 5.0
            ),
            ),
            ),
            Container(
              width: 150.0,
              height: 50,
            child:ElevatedButton(
              // 버튼 누르면 페이지 이동
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Seoul()));
              },
            child: Text('충 남',
            style: TextStyle(fontSize: 20, color: Colors.white),),
            style: ElevatedButton.styleFrom(
              primary: Colors.orangeAccent,
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              elevation: 5.0
            ),
            ),
            
            ),
          ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
            Container(
              width: 150.0,
              height: 50,
            child:ElevatedButton(
              // 버튼 누르면 페이지 이동
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Seoul()));
              },
            child: Text('전 남',
            style: TextStyle(fontSize: 20, color: Colors.white),),
            style: ElevatedButton.styleFrom(
              primary: Colors.orangeAccent,
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              elevation: 5.0
            ),
            ),
            ),
            Container(
              width: 150.0,
              height: 50,
            child:ElevatedButton(
              // 버튼 누르면 페이지 이동
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Seoul()));
              },
            child: Text('전 북',
            style: TextStyle(fontSize: 20, color: Colors.white),),
            style: ElevatedButton.styleFrom(
              primary: Colors.orangeAccent,
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              elevation: 5.0
            ),
            ),
            
            ),
          ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
            Container(
              width: 150.0,
              height: 50,
            child:ElevatedButton(
              // 버튼 누르면 페이지 이동
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Seoul()));
              },
            child: Text('충 북',
            style: TextStyle(fontSize: 20, color: Colors.white),),
            style: ElevatedButton.styleFrom(
              primary: Colors.orangeAccent,
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              elevation: 5.0
            ),
            ),
            ),
            Container(
              width: 150.0,
              height: 50,
            child:ElevatedButton(
              // 버튼 누르면 페이지 이동
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Seoul()));
              },
            child: Text('강 원',
            style: TextStyle(fontSize: 20, color: Colors.white),),
            style: ElevatedButton.styleFrom(
              primary: Colors.orangeAccent,
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              elevation: 5.0
            ),
            ),
            
            ),
          ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
            Container(
              width: 150.0,
              height: 50,
            child:ElevatedButton(
              // 버튼 누르면 페이지 이동
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Seoul()));
              },
            child: Text('대 전',
            style: TextStyle(fontSize: 20, color: Colors.white),),
            style: ElevatedButton.styleFrom(
              primary: Colors.orangeAccent,
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              elevation: 5.0
            ),
            ),
            ),
            Container(
              width: 150.0,
              height: 50,
            child:ElevatedButton(
              // 버튼 누르면 페이지 이동
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Seoul()));
              },
            child: Text('광 주',
            style: TextStyle(fontSize: 20, color: Colors.white),),
            style: ElevatedButton.styleFrom(
              primary: Colors.orangeAccent,
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              elevation: 5.0
            ),
            ),
            
            ),
          ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
            Container(
              width: 150.0,
              height: 50,
            child:ElevatedButton(
              // 버튼 누르면 페이지 이동
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Seoul()));
              },
            child: Text('울 산',
            style: TextStyle(fontSize: 20, color: Colors.white),),
            style: ElevatedButton.styleFrom(
              primary: Colors.orangeAccent,
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              elevation: 5.0
            ),
            ),
            ),
            Container(
              width: 150.0,
              height: 50,
            child:ElevatedButton(
              // 버튼 누르면 페이지 이동
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Seoul()));
              },
            child: Text('제 주',
            style: TextStyle(fontSize: 20, color: Colors.white),),
            style: ElevatedButton.styleFrom(
              primary: Colors.orangeAccent,
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              elevation: 5.0
            ),
            ),
            
            ),
          ],
            ),
            
          ],
        ),
      ),

    );
  }
}

class Seoul extends StatelessWidget {
  const Seoul({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('병원 찾기'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
            Container(
              width: 100.0,
              height: 50,
            child:ElevatedButton(
              // 버튼 누르면 페이지 이동
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Seoul()));
              },
            child: Text('강남구',
            style: TextStyle(fontSize: 20, color: Colors.white),),
            style: ElevatedButton.styleFrom(
              primary: Colors.orangeAccent,
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              elevation: 5.0
            ),
            ),
            ),
            Container(
              width: 100.0,
              height: 50,
            child:ElevatedButton(
              // 버튼 누르면 페이지 이동
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Seoul()));
              },
            child: Text('강동구',
            style: TextStyle(fontSize: 20, color: Colors.white),),
            style: ElevatedButton.styleFrom(
              primary: Colors.orangeAccent,
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              elevation: 5.0
            ),
            ),
            
            ),
            Container(
              width: 100.0,
              height: 50,
            child:ElevatedButton(
              // 버튼 누르면 페이지 이동
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Seoul()));
              },
            child: Text('강북구',
            style: TextStyle(fontSize: 20, color: Colors.white),),
            style: ElevatedButton.styleFrom(
              primary: Colors.orangeAccent,
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              elevation: 5.0
            ),
            ),
            
            ),
          ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
            Container(
              width: 100.0,
              height: 50,
            child:ElevatedButton(
              // 버튼 누르면 페이지 이동
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Seoul()));
              },
            child: Text('강서구',
            style: TextStyle(fontSize: 20, color: Colors.white),),
            style: ElevatedButton.styleFrom(
              primary: Colors.orangeAccent,
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              elevation: 5.0
            ),
            ),
            ),
            Container(
              width: 100.0,
              height: 50,
            child:ElevatedButton(
              // 버튼 누르면 페이지 이동
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Seoul()));
              },
            child: Text('관악구',
            style: TextStyle(fontSize: 20, color: Colors.white),),
            style: ElevatedButton.styleFrom(
              primary: Colors.orangeAccent,
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              elevation: 5.0
            ),
            ),
            
            ),
            Container(
              width: 100.0,
              height: 50,
            child:ElevatedButton(
              // 버튼 누르면 페이지 이동
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Seoul()));
              },
            child: Text('광진구',
            style: TextStyle(fontSize: 20, color: Colors.white),),
            style: ElevatedButton.styleFrom(
              primary: Colors.orangeAccent,
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              elevation: 5.0
            ),
            ),
            
            ),
          ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
            Container(
              width: 100.0,
              height: 50,
            child:ElevatedButton(
              // 버튼 누르면 페이지 이동
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Guro()));
              },
            child: Text('구로구',
            style: TextStyle(fontSize: 20, color: Colors.white),),
            style: ElevatedButton.styleFrom(
              primary: Colors.orangeAccent,
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              elevation: 5.0
            ),
            ),
            ),
            Container(
              width: 100.0,
              height: 50,
            child:ElevatedButton(
              // 버튼 누르면 페이지 이동
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Seoul()));
              },
            child: Text('금천구',
            style: TextStyle(fontSize: 20, color: Colors.white),),
            style: ElevatedButton.styleFrom(
              primary: Colors.orangeAccent,
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              elevation: 5.0
            ),
            ),
            
            ),
            Container(
              width: 100.0,
              height: 50,
            child:ElevatedButton(
              // 버튼 누르면 페이지 이동
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Seoul()));
              },
            child: Text('노원구',
            style: TextStyle(fontSize: 20, color: Colors.white),),
            style: ElevatedButton.styleFrom(
              primary: Colors.orangeAccent,
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              elevation: 5.0
            ),
            ),
            
            ),
          ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
            Container(
              width: 100.0,
              height: 50,
            child:ElevatedButton(
              // 버튼 누르면 페이지 이동
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Seoul()));
              },
            child: Text('도봉구',
            style: TextStyle(fontSize: 20, color: Colors.white),),
            style: ElevatedButton.styleFrom(
              primary: Colors.orangeAccent,
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              elevation: 5.0
            ),
            ),
            ),
            Container(
              width: 100.0,
              height: 50,
            child:ElevatedButton(
              // 버튼 누르면 페이지 이동
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Seoul()));
              },
            child: Text('동대문구',
            style: TextStyle(fontSize: 18, color: Colors.white),),
            style: ElevatedButton.styleFrom(
              primary: Colors.orangeAccent,
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              elevation: 5.0
            ),
            ),
            
            ),
            Container(
              width: 100.0,
              height: 50,
            child:ElevatedButton(
              // 버튼 누르면 페이지 이동
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Seoul()));
              },
            child: Text('동작구',
            style: TextStyle(fontSize: 20, color: Colors.white),),
            style: ElevatedButton.styleFrom(
              primary: Colors.orangeAccent,
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              elevation: 5.0
            ),
            ),
            
            ),
          ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
            Container(
              width: 100.0,
              height: 50,
            child:ElevatedButton(
              // 버튼 누르면 페이지 이동
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Seoul()));
              },
            child: Text('마포구',
            style: TextStyle(fontSize: 20, color: Colors.white),),
            style: ElevatedButton.styleFrom(
              primary: Colors.orangeAccent,
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              elevation: 5.0
            ),
            ),
            ),
            Container(
              width: 100.0,
              height: 50,
            child:ElevatedButton(
              // 버튼 누르면 페이지 이동
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Seoul()));
              },
            child: Text('서대문구',
            style: TextStyle(fontSize: 18, color: Colors.white),),
            style: ElevatedButton.styleFrom(
              primary: Colors.orangeAccent,
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              elevation: 5.0
            ),
            ),
            
            ),
            Container(
              width: 100.0,
              height: 50,
            child:ElevatedButton(
              // 버튼 누르면 페이지 이동
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Seoul()));
              },
            child: Text('서초구',
            style: TextStyle(fontSize: 20, color: Colors.white),),
            style: ElevatedButton.styleFrom(
              primary: Colors.orangeAccent,
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              elevation: 5.0
            ),
            ),
            
            ),
          ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
            Container(
              width: 100.0,
              height: 50,
            child:ElevatedButton(
              // 버튼 누르면 페이지 이동
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Seoul()));
              },
            child: Text('성동구',
            style: TextStyle(fontSize: 20, color: Colors.white),),
            style: ElevatedButton.styleFrom(
              primary: Colors.orangeAccent,
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              elevation: 5.0
            ),
            ),
            ),
            Container(
              width: 100.0,
              height: 50,
            child:ElevatedButton(
              // 버튼 누르면 페이지 이동
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Seoul()));
              },
            child: Text('성북구',
            style: TextStyle(fontSize: 20, color: Colors.white),),
            style: ElevatedButton.styleFrom(
              primary: Colors.orangeAccent,
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              elevation: 5.0
            ),
            ),
            
            ),
            Container(
              width: 100.0,
              height: 50,
            child:ElevatedButton(
              // 버튼 누르면 페이지 이동
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Seoul()));
              },
            child: Text('송파구',
            style: TextStyle(fontSize: 20, color: Colors.white),),
            style: ElevatedButton.styleFrom(
              primary: Colors.orangeAccent,
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              elevation: 5.0
            ),
            ),
            
            ),
          ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
            Container(
              width: 100.0,
              height: 50,
            child:ElevatedButton(
              // 버튼 누르면 페이지 이동
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Seoul()));
              },
            child: Text('양천구',
            style: TextStyle(fontSize: 20, color: Colors.white),),
            style: ElevatedButton.styleFrom(
              primary: Colors.orangeAccent,
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              elevation: 5.0
            ),
            ),
            ),
            Container(
              width: 100.0,
              height: 50,
            child:ElevatedButton(
              // 버튼 누르면 페이지 이동
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Seoul()));
              },
            child: Text('영등포구',
            style: TextStyle(fontSize: 18, color: Colors.white),),
            style: ElevatedButton.styleFrom(
              primary: Colors.orangeAccent,
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              elevation: 5.0
            ),
            ),
            
            ),
            Container(
              width: 100.0,
              height: 50,
            child:ElevatedButton(
              // 버튼 누르면 페이지 이동
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Seoul()));
              },
            child: Text('용산구',
            style: TextStyle(fontSize: 20, color: Colors.white),),
            style: ElevatedButton.styleFrom(
              primary: Colors.orangeAccent,
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              elevation: 5.0
            ),
            ),
            
            ),
          ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
            Container(
              width: 100.0,
              height: 50,
            child:ElevatedButton(
              // 버튼 누르면 페이지 이동
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Seoul()));
              },
            child: Text('은평구',
            style: TextStyle(fontSize: 20, color: Colors.white),),
            style: ElevatedButton.styleFrom(
              primary: Colors.orangeAccent,
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              elevation: 5.0
            ),
            ),
            ),
            Container(
              width: 100.0,
              height: 50,
            child:ElevatedButton(
              // 버튼 누르면 페이지 이동
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Seoul()));
              },
            child: Text('종로구',
            style: TextStyle(fontSize: 20, color: Colors.white),),
            style: ElevatedButton.styleFrom(
              primary: Colors.orangeAccent,
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              elevation: 5.0
            ),
            ),
            
            ),
            Container(
              width: 100.0,
              height: 50,
            child:ElevatedButton(
              // 버튼 누르면 페이지 이동
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Seoul()));
              },
            child: Text('중구',
            style: TextStyle(fontSize: 20, color: Colors.white),),
            style: ElevatedButton.styleFrom(
              primary: Colors.orangeAccent,
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              elevation: 5.0
            ),
            ),
            
            ),
          ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
            Container(
              width: 100.0,
              height: 50,
            child:ElevatedButton(
              // 버튼 누르면 페이지 이동
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Seoul()));
              },
            child: Text('중랑구',
            style: TextStyle(fontSize: 20, color: Colors.white),),
            style: ElevatedButton.styleFrom(
              primary: Colors.orangeAccent,
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              elevation: 5.0
            ),
            ),
            ),
          ],
            ),
          ],
        ),
      ),
    );
  }
}
