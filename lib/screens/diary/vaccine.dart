import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VaccineScreen extends StatefulWidget {
  const VaccineScreen({Key? key}) : super(key: key);

  @override
  State<VaccineScreen> createState() => _VaccineScreenState();
}

class _VaccineScreenState extends State<VaccineScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  User user = FirebaseAuth.instance.currentUser!;
  String? _dose; // Declare the TabController

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 3, vsync: this); // Initialize the TabController
  }

  @override
  void dispose() {
    _tabController.dispose(); // Dispose the TabController to avoid memory leaks
    super.dispose();
  }

  _create(String vaccineName) {
    TextEditingController nameController = TextEditingController();
    TextEditingController hospitalController = TextEditingController();
    TextEditingController doseController = TextEditingController();
    TextEditingController dateController = TextEditingController();

    late CollectionReference items = FirebaseFirestore.instance
        .collection('vaccine')
        .doc(user.uid)
        .collection('vaccineSchedule');
    return () {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      const Text(
                        '접종 기록',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () async {
                              Navigator.of(context).pop();

                              await items.add({
                                'name': vaccineName,
                                'hospital': hospitalController.text,
                                'dose': doseController.text,
                                'date': dateController.text,
                              });
                            },
                            child: const Text(
                              '저장',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.grey.shade400,
                  ),
                  TextField(
                    controller: hospitalController,
                    decoration: const InputDecoration(
                      labelText: '접종 병원',
                      labelStyle: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  TextField(
                    controller: doseController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: '접종 차수',
                      hintText: '숫자만 입력해주세요 (예: 1)',
                      labelStyle: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );

                      if (pickedDate != null && pickedDate != DateTime.now()) {
                        setState(() {
                          dateController.text =
                              pickedDate.toLocal().toString().split(' ')[0];
                        });
                      }
                    },
                    child: IgnorePointer(
                      child: TextField(
                        controller: dateController,
                        keyboardType: TextInputType.datetime,
                        decoration: const InputDecoration(
                          labelText: '접종 날짜',
                          labelStyle: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('예방접종 기록'),
        bottom: TabBar(
          controller: _tabController, // Assign the TabController to the TabBar
          tabs: const [
            Tab(text: '강아지'),
            Tab(text: '고양이'),
            Tab(text: '접종확인'),
          ],
        ),
      ),
      body: TabBarView(
        controller:
            _tabController, // Assign the TabController to the TabBarView
        children: [
          _buildDogVaccinationSchedule(),
          _buildCatVaccinationSchedule(),
          _buildVaccinationSchedule(),
        ],
      ),
    );
  }

  Widget _buildDogVaccinationSchedule() {
    return ListView(
      children: [
        ExpansionTile(
          title: const Text('혼합예방주사(DHPPL)'),
          trailing: TextButton(
            onPressed: _create('혼합예방주사(DHPPL)'),
            child: const Text('접종기록'),
          ),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildVaccineContainer('기초접종 : 생후 6 ~ 8주에 1차 접종'),
                _buildVaccineContainer('추가접종 : 1차 접종 후 2 ~ 4주 간격으로 2 ~ 4회'),
                _buildVaccineContainer('보강접종 : 추가접종 후 매년 1회 주사'),
              ],
            )
          ],
        ),
        ExpansionTile(
          title: const Text('코로나바이러스성 장염'),
          trailing: TextButton(
            onPressed: _create('코로나바이러스성 장염'),
            child: const Text('접종기록'),
          ),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildVaccineContainer('기초접종 : 생후 6 ~ 8주에 1차 접종	'),
                _buildVaccineContainer('추가접종 : 1차 접종 후 2 ~ 4주 간격으로 1 ~ 2회'),
                _buildVaccineContainer('보강접종 : 추가접종 후 매년 1회 주사'),
              ],
            ),
          ],
        ),
        ExpansionTile(
          title: const Text('기관지염'),
          trailing: TextButton(
            onPressed: _create('기관지염'),
            child: const Text('접종기록'),
          ),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildVaccineContainer('기초접종 : 생후 6 ~ 8주에 1차 접종	'),
                _buildVaccineContainer('추가접종 : 1차 접종 후 2 ~ 4주 간격으로 1 ~ 2회'),
                _buildVaccineContainer('보강접종 : 추가접종 후 매년 1회 주사'),
              ],
            ),
          ],
        ),
        ExpansionTile(
          title: const Text('광견병'),
          trailing: TextButton(
            onPressed: _create('광견병'),
            child: const Text('접종기록'),
          ),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildVaccineContainer('기초접종 : 생후 3개월 이상 1회 접종	'),
                _buildVaccineContainer('보강접종 : 6개월 간격으로 주사'),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCatVaccinationSchedule() {
    return ListView(
      children: [
        ExpansionTile(
          title: const Text('혼합예방주사(CVRP)'),
          trailing: TextButton(
            onPressed: _create('혼합예방주사(CVRP)'),
            child: const Text('접종기록'),
          ),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildVaccineContainer('기초접종 : 생후 6 ~ 8주에 1차 접종'),
                _buildVaccineContainer('추가접종 : 1차 접종 후 2 ~ 4주 간격으로 2 ~ 3회'),
                _buildVaccineContainer('보강접종 : 추가접종 후 매년 1회 주사'),
              ],
            ),
          ],
        ),
        ExpansionTile(
          title: const Text('고양이 백혈병(Feline Leukemia)'),
          trailing: TextButton(
            onPressed: _create('고양이 백혈병'),
            child: const Text('접종기록'),
          ),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildVaccineContainer('기초접종 : 생후 9 ~ 11주에 1차 접종'),
                _buildVaccineContainer('추가접종 : 1차 접종 후 2 ~ 4주 간격으로 1 ~ 2회'),
                _buildVaccineContainer('보강접종 : 추가접종 후 매년 1회 주사'),
              ],
            ),
          ],
        ),
        ExpansionTile(
          title: const Text('전염성 복막염(RP)'),
          trailing: TextButton(
            onPressed: _create('전염성 복막염(RP)'),
            child: const Text('접종기록'),
          ),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildVaccineContainer('추가접종 : 1차 접종 후 2 ~ 3주 간격으로 1회'),
                _buildVaccineContainer('보강접종 : 추가접종 후 매년 1회 주사'),
              ],
            ),
          ],
        ),
        ExpansionTile(
          title: const Text('광견병'),
          trailing: TextButton(
            onPressed: _create('광견병'),
            child: const Text('접종기록'),
          ),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildVaccineContainer('기초접종 : 생후 3개월 이상 1회 접종'),
                _buildVaccineContainer('보강접종 : 1개월 간격으로 주사'),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildVaccineContainer(String type) {
    return Container(
      padding: const EdgeInsets.all(15),
      color: Colors.grey[200],
      child: Text(
        type,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildVaccinationSchedule() {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('vaccine')
            .doc(user.uid)
            .collection('vaccineSchedule')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data!.docs[index];
              return ListTile(
                title: Row(
                  children: [
                    Text('${ds['dose']}차',
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red)),
                    const SizedBox(width: 10),
                    Text(ds['name'],
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                subtitle: Row(
                  children: [
                    Text(ds['date'], style: const TextStyle(fontSize: 15)),
                    const SizedBox(width: 10),
                    Text(ds['hospital'], style: const TextStyle(fontSize: 15)),
                  ],
                ),
                trailing: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: const Text("이 항목을 삭제하시겠습니까?",
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.center),
                          actions: <Widget>[
                            TextButton(
                              child: const Text("취소"),
                              onPressed: () {
                                Navigator.of(context).pop(); // 다이얼로그 닫기
                              },
                            ),
                            TextButton(
                              child: const Text("삭제"),
                              onPressed: () async {
                                Navigator.of(context).pop();

                                await FirebaseFirestore.instance
                                    .collection('vaccine')
                                    .doc(user.uid)
                                    .collection('vaccineSchedule')
                                    .doc(ds.id)
                                    .delete();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.more_vert),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
