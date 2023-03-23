import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:petai_care/screens/hospital/HospitalDataModel.dart';

// 서초부터 json 파일 복붙해서 크롤링으로 json 파일 수정해야함.

// 강남구

class Gangnam extends StatefulWidget {
  const Gangnam({super.key});

  @override
  State<Gangnam> createState() => _GangnamState();
}

class _GangnamState extends State<Gangnam> {
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
    final jsondata = await rootBundle.rootBundle.loadString('jsonfile/gangnam.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();

  }

}

// 강동구

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

// 강북구

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
    final jsondata = await rootBundle.rootBundle.loadString('jsonfile/gangbuk.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();

  }

}

// 강서구

class Gangseo extends StatefulWidget {
  const Gangseo({super.key});

  @override
  State<Gangbuk> createState() => _GangbukState();
}

class _GangseoState extends State<Gangseo> {
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
    final jsondata = await rootBundle.rootBundle.loadString('jsonfile/gangseo.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();

  }

}

// 관악구

class Gwanak extends StatefulWidget {
  const Gwanak({super.key});

  @override
  State<Gwanak> createState() => _GwanakState();
}

class _GwanakState extends State<Gwanak> {
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
    final jsondata = await rootBundle.rootBundle.loadString('jsonfile/gwanak.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();

  }

}

// 광진구

class Gwangjin extends StatefulWidget {
  const Gwangjin({super.key});

  @override
  State<Gwangjin> createState() => _GwangjinState();
}

class _GwangjinState extends State<Gwangjin> {
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
    final jsondata = await rootBundle.rootBundle.loadString('jsonfile/gwangjin.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();
  }
}


// 구로구

class Guro extends StatefulWidget {
  const Guro({super.key});

  @override
  State<Guro> createState() => _GuroState();
}

class _GuroState extends State<Guro> {
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
    final jsondata = await rootBundle.rootBundle.loadString('jsonfile/guro.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();

  }

}

// 금천구

class Geumcheon extends StatefulWidget {
  const Geumcheon({super.key});

  @override
  State<Geumcheon> createState() => _GeumcheonState();
}

class _GeumcheonState extends State<Geumcheon> {
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
    final jsondata = await rootBundle.rootBundle.loadString('jsonfile/geumcheon.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();
  }
}

// 노원구

class Nowon extends StatefulWidget {
  const Nowon({super.key});

  @override
  State<Nowon> createState() => _NowonState();
}

class _NowonState extends State<Nowon> {
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
    final jsondata = await rootBundle.rootBundle.loadString('jsonfile/nowon.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();
  }
}

// 도봉구

class Dobong extends StatefulWidget {
  const Dobong({super.key});

  @override
  State<Dobong> createState() => _DobongState();
}

class _DobongState extends State<Dobong> {
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
    final jsondata = await rootBundle.rootBundle.loadString('jsonfile/dobong.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();
  }
}

// 동대문구

class Dongdaemun extends StatefulWidget {
  const Dongdaemun({super.key});

  @override
  State<Dongdaemun> createState() => _DongdaemunState();
}

class _DongdaemunState extends State<Dongdaemun> {
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
    final jsondata = await rootBundle.rootBundle.loadString('jsonfile/dongdaemun.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();
  }
}

// 동작구

class Dongjak extends StatefulWidget {
  const Dongjak({super.key});

  @override
  State<Dongjak> createState() => _DongjakState();
}

class _DongjakState extends State<Dongjak> {
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
    final jsondata = await rootBundle.rootBundle.loadString('jsonfile/dongjak.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();
  }
}

// 마포구

class Mapo extends StatefulWidget {
  const Mapo({super.key});

  @override
  State<Mapo> createState() => _MapoState();
}

class _MapoState extends State<Mapo> {
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
    final jsondata = await rootBundle.rootBundle.loadString('jsonfile/mapo.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();
  }
}

// 서대문구

class Seodaemun extends StatefulWidget {
  const Seodaemun({super.key});

  @override
  State<Seodaemun> createState() => _SeodaemunState();
}

class _SeodaemunState extends State<Seodaemun> {
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
    final jsondata = await rootBundle.rootBundle.loadString('jsonfile/seodaemun.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();
  }
}

// 서초구

class Seocho extends StatefulWidget {
  const Seocho({super.key});

  @override
  State<Seocho> createState() => _SeochoState();
}

class _SeochoState extends State<Seocho> {
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
    final jsondata = await rootBundle.rootBundle.loadString('jsonfile/seocho.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();
  }
}

// 성동구

class Seongdong extends StatefulWidget {
  const Seongdong({super.key});

  @override
  State<Seongdong> createState() => _SeongdongState();
}

class _SeongdongState extends State<Seongdong> {
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
    final jsondata = await rootBundle.rootBundle.loadString('jsonfile/seongdong.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();
  }
}

// 성북구

class Seongbuk extends StatefulWidget {
  const Seongbuk({super.key});

  @override
  State<Seongbuk> createState() => _SeongbukState();
}

class _SeongbukState extends State<Seongbuk> {
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
    final jsondata = await rootBundle.rootBundle.loadString('jsonfile/seongbuk.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();
  }
}

// 송파구

class Songpa extends StatefulWidget {
  const Songpa({super.key});

  @override
  State<Songpa> createState() => _SongpaState();
}

class _SongpaState extends State<Songpa> {
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
    final jsondata = await rootBundle.rootBundle.loadString('jsonfile/songpa.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();
  }
}

// 양천구

class Yangcheon extends StatefulWidget {
  const Yangcheon({super.key});

  @override
  State<Yangcheon> createState() => _YangcheonState();
}

class _YangcheonState extends State<Yangcheon> {
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
    final jsondata = await rootBundle.rootBundle.loadString('jsonfile/yangcheon.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();
  }
}

// 영등포구

class Yeongdeungpo extends StatefulWidget {
  const Yeongdeungpo({super.key});

  @override
  State<Yeongdeungpo> createState() => _YeongdeungpoState();
}

class _YeongdeungpoState extends State<Yeongdeungpo> {
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
    final jsondata = await rootBundle.rootBundle.loadString('jsonfile/yeongdeungpo.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();
  }
}

// 용산구

class Yongsan extends StatefulWidget {
  const Yongsan({super.key});

  @override
  State<Yongsan> createState() => _YongsanState();
}

class _YongsanState extends State<Yongsan> {
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
    final jsondata = await rootBundle.rootBundle.loadString('jsonfile/yongsan.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();
  }
}

// 은평구

class Eunpyeong extends StatefulWidget {
  const Eunpyeong({super.key});

  @override
  State<Eunpyeong> createState() => _EunpyeongState();
}

class _EunpyeongState extends State<Eunpyeong> {
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
    final jsondata = await rootBundle.rootBundle.loadString('jsonfile/eunpyeong.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();
  }
}

// 종로구

class Jongno extends StatefulWidget {
  const Jongno({super.key});

  @override
  State<Jongno> createState() => _JongnoState();
}

class _JongnoState extends State<Jongno> {
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
    final jsondata = await rootBundle.rootBundle.loadString('jsonfile/jongno.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();
  }
}

// 중구

class Jung extends StatefulWidget {
  const Jung({super.key});

  @override
  State<Jung> createState() => _JungState();
}

class _JungState extends State<Jung> {
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
    final jsondata = await rootBundle.rootBundle.loadString('jsonfile/jung.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();
  }
}

// 중랑구

class Jungnang extends StatefulWidget {
  const Jungnang({super.key});

  @override
  State<Jungnang> createState() => _JungnangState();
}

class _JungnangState extends State<Jungnang> {
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
    final jsondata = await rootBundle.rootBundle.loadString('jsonfile/jungnang.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HospitalDataModel.fromJson(e)).toList();
  }
}
































