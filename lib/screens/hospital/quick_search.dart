import 'package:flutter/material.dart';

class QuickSearch extends StatefulWidget {
  const QuickSearch({super.key});


  @override
  State<QuickSearch> createState() => _QuickSearchState();
}

class _QuickSearchState extends State<QuickSearch> {

  List<Map<String, dynamic>> _allHospitals = [

 {"id": 1,"name": "둘리동물병원","address": "서울 도봉구 창동"},
 {"id": 2,"name": "별난동물병원","address": "서울 도봉구 쌍문2동"},
 {"id": 3,"name": "365동물병원","address": "서울 도봉구 방학동"},
 {"id": 4,"name": "삼성동물병원","address": "서울 도봉구 쌍문동"},
 {"id": 5,"name": "강북우리동물의료센터","address": "서울 도봉구 창동"},
 {"id": 6,"name": "하비동물병원","address": "서울 도봉구 창5동"},
 {"id": 7,"name": "보듬동물병원","address": "서울 도봉구 쌍문동"},
 {"id": 8,"name": "화신종합동물병원","address": "서울 도봉구 방학동"},
 {"id": 9,"name": "방학동물병원","address": "서울 도봉구 방학동"},
 {"id": 10,"name": "트윈스동물병원","address": "서울 도봉구 창동"},
 {"id": 11,"name": "해봄동물병원","address": "서울 도봉구 도봉동"},
 {"id": 12,"name": "현대종합동물병원","address": "서울 도봉구 방학동"},
 {"id": 13,"name": "아이조은동물병원","address": "서울 도봉구 쌍문동"},
 {"id": 14,"name": "태일동물병원","address": "서울 도봉구 쌍문동"},
 {"id": 15,"name": "가나동물병원","address": "서울 도봉구 방학동"},
 {"id": 16,"name": "김미경동물병원","address": "서울 도봉구 도봉동"},
 {"id": 17,"name": "퓨리나 동물병원","address": "서울 도봉구 쌍문3동"},
 {"id": 18,"name": "한빛동물병원","address": "서울 도봉구 창동"},
 {"id": 19,"name": "행복한 동물병원","address": "서울 도봉구 창5동"},
 {"id": 20,"name": "사랑해요동물병원","address": "서울 도봉구 쌍문동"},
 {"id": 21,"name": "유현동물병원","address": "서울 도봉구 방학동"}
 
];

  List<Map<String, dynamic>> _foundHospitals = [];
  @override
  initState() {
    _foundHospitals = _allHospitals;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty){
      results = _allHospitals;
    } else {
      results = _allHospitals.where((hospital) =>hospital["name"].toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
      results = _allHospitals.where((hospital) =>hospital["address"].toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
    }
    

    setState(() {
      _foundHospitals = results;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          TextField(
            onChanged: (value) => _runFilter(value),
            decoration: InputDecoration(
              labelText: 'search', suffixIcon: Icon(Icons.search)),
          ),
        const SizedBox(
            height: 20,
          ),
        Expanded(
        child:ListView.builder(
         itemCount: _foundHospitals.length,
         itemBuilder: (context, index) => Card(
          key: ValueKey(_foundHospitals[index]["id"]),
          color: Colors.lightBlue,
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: ListTile(
            leading: Text(
              _foundHospitals[index]["id"].toString(),
              style: const TextStyle(fontSize: 24, color: Colors.white),
            ),
            title: Text(_foundHospitals[index]['name'],
                style: TextStyle(color: Colors.white)),
            subtitle: Text(_foundHospitals[index]['address'],
                style: TextStyle(color: Colors.white)),
              ),
            ),
           ),
          ),
          ],
        ),
      ),
    );
  }
}