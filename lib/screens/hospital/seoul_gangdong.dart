import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:petai_care/screens/hospital/HospitalDataModel.dart';

class Gangdong extends StatefulWidget {
  const Gangdong({super.key});

  @override
  State<Gangdong> createState() => _GangdongState();
}

class _GangdongState extends State<Gangdong> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("병원 찾기"),
      ),
      body:Column(
        children: [
      FutureBuilder(
        future: ReadJsonData(),
        builder: (context,data){
          if(data.hasError){
            return Center(child: Text("${data.error}"));
          }else if(data.hasData){
            var items = data.data as List<HospitalDataModel>;
            return Expanded(
              child: ListView.builder(
                itemCount: items == null? 0: items.length,
                itemBuilder: (context,index){
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            child: Image(image: NetworkImage(items[index].imageUrl.toString()),fit: BoxFit.fill,),
                          ),
                          Expanded(child: Container(
                            padding: EdgeInsets.only(bottom: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(padding: EdgeInsets.only(left: 8, right: 8), child: Text(items[index].name.toString(),style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                                ),),),
                                Padding(padding: EdgeInsets.only(left: 8, right: 8), child: Text(items[index].address.toString()),),
                                Padding(padding: EdgeInsets.only(left: 8, right: 8), child: Text(items[index].number.toString()),)
                              ],
                            ),
                          ))
                        ],                
                      ),
                    ),
                  );
                }
              ),
            );
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      )
        ],

      ),
    );
  }

  Future<List<HospitalDataModel>>ReadJsonData() async{
    final jsondata = await rootBundle.rootBundle.loadString('jsonfile/gangdong.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();

  }

}