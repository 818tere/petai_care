import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:petai_care/screens/hospital/HospitalDataModel.dart';

void showPopup(context, imageUrl, name, address, number) {
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
                  height: 10,
                ),
                Text(
                  address,
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  number,
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

// 고양시

class Goyang extends StatefulWidget {
  const Goyang({super.key});

  @override
  State<Goyang> createState() => _GoyangState();
}

class _GoyangState extends State<Goyang> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        return GestureDetector(
                          onTap: () {
                            showPopup(
                                context,
                                items[index].imageUrl,
                                items[index].name,
                                items[index].address,
                                items[index].number);
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
        await rootBundle.rootBundle.loadString('jsonfile/gyeonggi/goyang.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();
  }
}

// 과천시

class Gwacheon extends StatefulWidget {
  const Gwacheon({super.key});

  @override
  State<Gwacheon> createState() => _GwacheonState();
}

class _GwacheonState extends State<Gwacheon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        return GestureDetector(
                          onTap: () {
                            showPopup(
                                context,
                                items[index].imageUrl,
                                items[index].name,
                                items[index].address,
                                items[index].number);
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
    final jsondata = await rootBundle.rootBundle
        .loadString('jsonfile/gyeonggi/gwacheon.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();
  }
}

// 광명시

class Gwangmyeong extends StatefulWidget {
  const Gwangmyeong({super.key});

  @override
  State<Gwangmyeong> createState() => _GwangmyeongState();
}

class _GwangmyeongState extends State<Gwangmyeong> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        return GestureDetector(
                          onTap: () {
                            showPopup(
                                context,
                                items[index].imageUrl,
                                items[index].name,
                                items[index].address,
                                items[index].number);
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
    final jsondata = await rootBundle.rootBundle
        .loadString('jsonfile/gyeonggi/gwangmyeong.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();
  }
}

// 광주시

class Gwangju extends StatefulWidget {
  const Gwangju({super.key});

  @override
  State<Gwangju> createState() => _GwangjuState();
}

class _GwangjuState extends State<Gwangju> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        return GestureDetector(
                          onTap: () {
                            showPopup(
                                context,
                                items[index].imageUrl,
                                items[index].name,
                                items[index].address,
                                items[index].number);
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
    final jsondata = await rootBundle.rootBundle
        .loadString('jsonfile/gyeonggi/gwangju.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();
  }
}

// 구리시

class Guri extends StatefulWidget {
  const Guri({super.key});

  @override
  State<Guri> createState() => _GuriState();
}

class _GuriState extends State<Guri> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        return GestureDetector(
                          onTap: () {
                            showPopup(
                                context,
                                items[index].imageUrl,
                                items[index].name,
                                items[index].address,
                                items[index].number);
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
        await rootBundle.rootBundle.loadString('jsonfile/gyeonggi/guri.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();
  }
}

// 군포시

class Gunpo extends StatefulWidget {
  const Gunpo({super.key});

  @override
  State<Gunpo> createState() => _GunpoState();
}

class _GunpoState extends State<Gunpo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        return GestureDetector(
                          onTap: () {
                            showPopup(
                                context,
                                items[index].imageUrl,
                                items[index].name,
                                items[index].address,
                                items[index].number);
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
        await rootBundle.rootBundle.loadString('jsonfile/gyeonggi/gunpo.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();
  }
}

// 김포시

class Gimpo extends StatefulWidget {
  const Gimpo({super.key});

  @override
  State<Gimpo> createState() => _GimpoState();
}

class _GimpoState extends State<Gimpo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        return GestureDetector(
                          onTap: () {
                            showPopup(
                                context,
                                items[index].imageUrl,
                                items[index].name,
                                items[index].address,
                                items[index].number);
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
        await rootBundle.rootBundle.loadString('jsonfile/gyeonggi/gimpo.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();
  }
}

// 남양주시

class Namyangju extends StatefulWidget {
  const Namyangju({super.key});

  @override
  State<Namyangju> createState() => _NamyangjuState();
}

class _NamyangjuState extends State<Namyangju> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        return GestureDetector(
                          onTap: () {
                            showPopup(
                                context,
                                items[index].imageUrl,
                                items[index].name,
                                items[index].address,
                                items[index].number);
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
    final jsondata = await rootBundle.rootBundle
        .loadString('jsonfile/gyeonggi/namyangju.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();
  }
}

// 동두천시

class Dongducheon extends StatefulWidget {
  const Dongducheon({super.key});

  @override
  State<Dongducheon> createState() => _DongducheonState();
}

class _DongducheonState extends State<Dongducheon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        return GestureDetector(
                          onTap: () {
                            showPopup(
                                context,
                                items[index].imageUrl,
                                items[index].name,
                                items[index].address,
                                items[index].number);
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
    final jsondata = await rootBundle.rootBundle
        .loadString('jsonfile/gyeonggi/dongducheon.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();
  }
}

// 부천시

class Bucheon extends StatefulWidget {
  const Bucheon({super.key});

  @override
  State<Bucheon> createState() => _BucheonState();
}

class _BucheonState extends State<Bucheon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        return GestureDetector(
                          onTap: () {
                            showPopup(
                                context,
                                items[index].imageUrl,
                                items[index].name,
                                items[index].address,
                                items[index].number);
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
    final jsondata = await rootBundle.rootBundle
        .loadString('jsonfile/gyeonggi/bucheon.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();
  }
}

// 성남시

class Seongnam extends StatefulWidget {
  const Seongnam({super.key});

  @override
  State<Seongnam> createState() => _SeongnamState();
}

class _SeongnamState extends State<Seongnam> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        return GestureDetector(
                          onTap: () {
                            showPopup(
                                context,
                                items[index].imageUrl,
                                items[index].name,
                                items[index].address,
                                items[index].number);
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
    final jsondata = await rootBundle.rootBundle
        .loadString('jsonfile/gyeonggi/seongnam.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();
  }
}

// 수원시

class Suwon extends StatefulWidget {
  const Suwon({super.key});

  @override
  State<Suwon> createState() => _SuwonState();
}

class _SuwonState extends State<Suwon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        return GestureDetector(
                          onTap: () {
                            showPopup(
                                context,
                                items[index].imageUrl,
                                items[index].name,
                                items[index].address,
                                items[index].number);
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
        await rootBundle.rootBundle.loadString('jsonfile/gyeonggi/suwon.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();
  }
}

// 시흥시

class Siheung extends StatefulWidget {
  const Siheung({super.key});

  @override
  State<Siheung> createState() => _SiheungState();
}

class _SiheungState extends State<Siheung> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        return GestureDetector(
                          onTap: () {
                            showPopup(
                                context,
                                items[index].imageUrl,
                                items[index].name,
                                items[index].address,
                                items[index].number);
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
    final jsondata = await rootBundle.rootBundle
        .loadString('jsonfile/gyeonggi/siheung.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();
  }
}

// 안산시

class Ansan extends StatefulWidget {
  const Ansan({super.key});

  @override
  State<Ansan> createState() => _AnsanState();
}

class _AnsanState extends State<Ansan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        return GestureDetector(
                          onTap: () {
                            showPopup(
                                context,
                                items[index].imageUrl,
                                items[index].name,
                                items[index].address,
                                items[index].number);
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
        await rootBundle.rootBundle.loadString('jsonfile/gyeonggi/ansan.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();
  }
}

// 안성시

class Anseong extends StatefulWidget {
  const Anseong({super.key});

  @override
  State<Anseong> createState() => _AnseongState();
}

class _AnseongState extends State<Anseong> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        return GestureDetector(
                          onTap: () {
                            showPopup(
                                context,
                                items[index].imageUrl,
                                items[index].name,
                                items[index].address,
                                items[index].number);
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
    final jsondata = await rootBundle.rootBundle
        .loadString('jsonfile/gyeonggi/anseong.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();
  }
}

// 안양시

class Anyang extends StatefulWidget {
  const Anyang({super.key});

  @override
  State<Anyang> createState() => _AnyangState();
}

class _AnyangState extends State<Anyang> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        return GestureDetector(
                          onTap: () {
                            showPopup(
                                context,
                                items[index].imageUrl,
                                items[index].name,
                                items[index].address,
                                items[index].number);
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
        await rootBundle.rootBundle.loadString('jsonfile/gyeonggi/anyang.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();
  }
}

// 양주시

class Yangju extends StatefulWidget {
  const Yangju({super.key});

  @override
  State<Yangju> createState() => _YangjuState();
}

class _YangjuState extends State<Yangju> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        return GestureDetector(
                          onTap: () {
                            showPopup(
                                context,
                                items[index].imageUrl,
                                items[index].name,
                                items[index].address,
                                items[index].number);
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
        await rootBundle.rootBundle.loadString('jsonfile/gyeonggi/yangju.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();
  }
}

// 여주시

class Yeoju extends StatefulWidget {
  const Yeoju({super.key});

  @override
  State<Yeoju> createState() => _YeojuState();
}

class _YeojuState extends State<Yeoju> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        return GestureDetector(
                          onTap: () {
                            showPopup(
                                context,
                                items[index].imageUrl,
                                items[index].name,
                                items[index].address,
                                items[index].number);
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
        await rootBundle.rootBundle.loadString('jsonfile/gyeonggi/yeoju.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();
  }
}

// 오산시

class Osan extends StatefulWidget {
  const Osan({super.key});

  @override
  State<Osan> createState() => _OsanState();
}

class _OsanState extends State<Osan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        return GestureDetector(
                          onTap: () {
                            showPopup(
                                context,
                                items[index].imageUrl,
                                items[index].name,
                                items[index].address,
                                items[index].number);
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
        await rootBundle.rootBundle.loadString('jsonfile/gyeonggi/osan.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();
  }
}

// 용인시

class Yongin extends StatefulWidget {
  const Yongin({super.key});

  @override
  State<Yongin> createState() => _YonginState();
}

class _YonginState extends State<Yongin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        return GestureDetector(
                          onTap: () {
                            showPopup(
                                context,
                                items[index].imageUrl,
                                items[index].name,
                                items[index].address,
                                items[index].number);
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
        await rootBundle.rootBundle.loadString('jsonfile/gyeonggi/yongin.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();
  }
}

// 의왕시

class Uiwang extends StatefulWidget {
  const Uiwang({super.key});

  @override
  State<Uiwang> createState() => _UiwangState();
}

class _UiwangState extends State<Uiwang> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        return GestureDetector(
                          onTap: () {
                            showPopup(
                                context,
                                items[index].imageUrl,
                                items[index].name,
                                items[index].address,
                                items[index].number);
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
        await rootBundle.rootBundle.loadString('jsonfile/gyeonggi/uiwang.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();
  }
}

// 의정부시

class Uijeongbu extends StatefulWidget {
  const Uijeongbu({super.key});

  @override
  State<Uijeongbu> createState() => _UijeongbuState();
}

class _UijeongbuState extends State<Uijeongbu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        return GestureDetector(
                          onTap: () {
                            showPopup(
                                context,
                                items[index].imageUrl,
                                items[index].name,
                                items[index].address,
                                items[index].number);
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
    final jsondata = await rootBundle.rootBundle
        .loadString('jsonfile/gyeonggi/uijeongbu.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();
  }
}

// 이천시

class Icheon extends StatefulWidget {
  const Icheon({super.key});

  @override
  State<Icheon> createState() => _IcheonState();
}

class _IcheonState extends State<Icheon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        return GestureDetector(
                          onTap: () {
                            showPopup(
                                context,
                                items[index].imageUrl,
                                items[index].name,
                                items[index].address,
                                items[index].number);
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
        await rootBundle.rootBundle.loadString('jsonfile/gyeonggi/icheon.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();
  }
}

// 파주시

class Paju extends StatefulWidget {
  const Paju({super.key});

  @override
  State<Paju> createState() => _PajuState();
}

class _PajuState extends State<Paju> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        return GestureDetector(
                          onTap: () {
                            showPopup(
                                context,
                                items[index].imageUrl,
                                items[index].name,
                                items[index].address,
                                items[index].number);
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
        await rootBundle.rootBundle.loadString('jsonfile/gyeonggi/paju.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();
  }
}

// 평택시

class Pyeongtaek extends StatefulWidget {
  const Pyeongtaek({super.key});

  @override
  State<Pyeongtaek> createState() => _PyeongtaekState();
}

class _PyeongtaekState extends State<Pyeongtaek> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        return GestureDetector(
                          onTap: () {
                            showPopup(
                                context,
                                items[index].imageUrl,
                                items[index].name,
                                items[index].address,
                                items[index].number);
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
    final jsondata = await rootBundle.rootBundle
        .loadString('jsonfile/gyeonggi/pyeongtaek.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();
  }
}

// 포천시

class Pocheon extends StatefulWidget {
  const Pocheon({super.key});

  @override
  State<Pocheon> createState() => _PocheonState();
}

class _PocheonState extends State<Pocheon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        return GestureDetector(
                          onTap: () {
                            showPopup(
                                context,
                                items[index].imageUrl,
                                items[index].name,
                                items[index].address,
                                items[index].number);
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
    final jsondata = await rootBundle.rootBundle
        .loadString('jsonfile/gyeonggi/pocheon.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();
  }
}

// 하남시

class Hanam extends StatefulWidget {
  const Hanam({super.key});

  @override
  State<Hanam> createState() => _HanamState();
}

class _HanamState extends State<Hanam> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        return GestureDetector(
                          onTap: () {
                            showPopup(
                                context,
                                items[index].imageUrl,
                                items[index].name,
                                items[index].address,
                                items[index].number);
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
        await rootBundle.rootBundle.loadString('jsonfile/gyeonggi/hanam.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();
  }
}

// 화성시

class Hwaseong extends StatefulWidget {
  const Hwaseong({super.key});

  @override
  State<Hwaseong> createState() => _HwaseongState();
}

class _HwaseongState extends State<Hwaseong> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        return GestureDetector(
                          onTap: () {
                            showPopup(
                                context,
                                items[index].imageUrl,
                                items[index].name,
                                items[index].address,
                                items[index].number);
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
    final jsondata = await rootBundle.rootBundle
        .loadString('jsonfile/gyeonggi/hwaseong.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();
  }
}
