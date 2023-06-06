import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:petai_care/screens/hospital/favorite_provider.dart';
import 'package:provider/provider.dart';
import 'HospitalDataModel.dart';

void showPopup(context, imageUrl, name, address, number, description) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: 380,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                      image: NetworkImage(imageUrl.toString()),
                      fit: BoxFit.fill),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                const SizedBox(
                  height: 7,
                ),
                Text(
                  address,
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                const SizedBox(
                  height: 7,
                ),
                Text(
                  number,
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                const SizedBox(
                  height: 7,
                ),
                Text(
                  description,
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              ],
            )),
      );
    },
  );
}

class MyFavoriteItemScreen extends StatefulWidget {
  const MyFavoriteItemScreen({super.key});

  @override
  State<MyFavoriteItemScreen> createState() => _MyFavoriteItemScreenState();
}

class _MyFavoriteItemScreenState extends State<MyFavoriteItemScreen> {
  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteItemProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: const <Widget>[],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    '동물병원',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          FutureBuilder(
            future: ReadJsonData(),
            builder: (context, data) {
              if (data.hasError) {
                return Center(child: Text("${data.error}"));
              } else if (data.hasData) {
                var items = data.data as List<HospitalDataModel>;
                return Expanded(
                  child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        if (!favoriteProvider.selectedItem.contains(index)) {
                          return const SizedBox.shrink();
                        }
                        return GestureDetector(
                          onTap: () {
                            showPopup(
                                context,
                                items[index - 1].imageUrl,
                                items[index - 1].name,
                                items[index - 1].address,
                                items[index - 1].number,
                                items[index - 1].description);
                          },
                          child: Card(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8),
                                          child: Text(
                                            items[index - 1].name.toString(),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8),
                                          child: Text(items[index - 1]
                                              .address
                                              .toString()),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8),
                                          child: Text(items[index - 1]
                                              .number
                                              .toString()),
                                        )
                                      ],
                                    ),
                                  )),
                                  IconButton(
                                    icon: Icon(
                                      favoriteProvider.selectedItem
                                              .contains(index)
                                          ? Icons.favorite
                                          : Icons.favorite_border_outlined,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      if (favoriteProvider.selectedItem
                                          .contains(index)) {
                                        favoriteProvider.removeItem(index);
                                      } else {
                                        favoriteProvider.addItem(index);
                                      }
                                      setState(() {});
                                    },
                                  ),
                                ],
                              ),
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
        await rootBundle.rootBundle.loadString('jsonfile/seoul/all.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();
  }
}
