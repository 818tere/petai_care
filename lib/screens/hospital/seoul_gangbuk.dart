import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:petai_care/screens/hospital/HospitalDataModel.dart';

class Gangbuk extends StatefulWidget {
  const Gangbuk({super.key});

  @override
  State<Gangbuk> createState() => _GangbukState();
}

class _GangbukState extends State<Gangbuk> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("병원 찾기"),
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: ReadJsonData(),
            builder: (context, data) {
              if (data.hasError) {
                return Center(child: Text("${data.error}"));
              } else if (data.hasData) {
                var items = data.data as List<HospitalDataModel>;
                return Expanded(
                  child: ListView.builder(
                      itemCount: items == null ? 0 : items.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 5,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Image(
                                    image: NetworkImage(
                                        items[index].imageUrl.toString()),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8),
                                        child: Text(
                                          items[index].name.toString(),
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8),
                                        child: Text(
                                            items[index].address.toString()),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8),
                                        child: Text(
                                            items[index].number.toString()),
                                      )
                                    ],
                                  ),
                                ))
                              ],
                            ),
                          ),
                        );
                      }),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )
        ],
      ),
    );
  }

  Future<List<HospitalDataModel>> ReadJsonData() async {
    final jsondata =
        await rootBundle.rootBundle.loadString('jsonfile/gangdbuk.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();
  }
}
