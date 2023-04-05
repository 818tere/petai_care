import 'package:flutter/material.dart';
import 'package:petai_care/screens/hospital/area_search.dart';
import 'package:petai_care/screens/hospital/quick_search.dart';

class HospitalScreen extends StatelessWidget {
  const HospitalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
                  width: 250.0,
                  height: 200,
                  child: ElevatedButton(
            
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const QuickSearch()));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        elevation: 5.0),
                    child: const Text(
                      '빠른 검색',
                      style: TextStyle(fontSize: 50, color: Colors.white),
                    ),
                  ),
                ),

          const SizedBox(height: 30),

          SizedBox(
                  width: 250.0,
                  height: 200,
                  child: ElevatedButton(
            
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AreaSearch()));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        elevation: 5.0),
                    child: const Text(
                      '지역 검색',
                      style: TextStyle(fontSize: 50, color: Colors.white),
                    ),
                  ),
                ),

        ],
        ),
      ),
    );
  }
}