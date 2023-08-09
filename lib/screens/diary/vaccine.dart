import 'package:flutter/material.dart';

class VaccineScreen extends StatefulWidget {
  const VaccineScreen({Key? key}) : super(key: key);

  @override
  State<VaccineScreen> createState() => _VaccineScreenState();
}

class _VaccineScreenState extends State<VaccineScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController; // Declare the TabController

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 2, vsync: this); // Initialize the TabController
  }

  @override
  void dispose() {
    _tabController.dispose(); // Dispose the TabController to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('예방접종 시기'),
        bottom: TabBar(
          controller: _tabController, // Assign the TabController to the TabBar
          tabs: const [
            Tab(text: '강아지'),
            Tab(text: '고양이'),
          ],
        ),
      ),
      body: TabBarView(
        controller:
            _tabController, // Assign the TabController to the TabBarView
        children: [
          _buildDogVaccinationSchedule(),
          _buildCatVaccinationSchedule(),
        ],
      ),
    );
  }

  Widget _buildDogVaccinationSchedule() {
    return ListView(
      children: [
        ExpansionTile(
          title: const Text('혼합예방주사(DHPPL)'),
          children: [
            _buildDogVaccineContainer('기초접종 : 생후 6 ~ 8주에 1차 접종'),
            _buildDogVaccineContainer('추가접종 : 1차 접종 후 2 ~ 4주 간격으로 2 ~ 4회'),
            _buildDogVaccineContainer('보강접종 : 추가접종 후 매년 1회 주사'),
          ],
        ),
        ExpansionTile(
          title: const Text('코로나바이러스성 장염'),
          children: [
            _buildDogVaccineContainer('기초접종 : 생후 6 ~ 8주에 1차 접종	'),
            _buildDogVaccineContainer('추가접종 : 1차 접종 후 2 ~ 4주 간격으로 1 ~ 2회'),
            _buildDogVaccineContainer('보강접종 : 추가접종 후 매년 1회 주사'),
          ],
        ),
        ExpansionTile(
          title: const Text('기관지염'),
          children: [
            _buildDogVaccineContainer('기초접종 : 생후 6 ~ 8주에 1차 접종	'),
            _buildDogVaccineContainer('추가접종 : 1차 접종 후 2 ~ 4주 간격으로 1 ~ 2회'),
            _buildDogVaccineContainer('보강접종 : 추가접종 후 매년 1회 주사'),
          ],
        ),
        ExpansionTile(
          title: const Text('광견병'),
          children: [
            _buildDogVaccineContainer('기초접종 : 생후 3개월 이상 1회 접종	'),
            _buildDogVaccineContainer('보강접종 : 6개월 간격으로 주사'),
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
          children: [
            _buildDogVaccineContainer('기초접종 : 생후 6 ~ 8주에 1차 접종'),
            _buildDogVaccineContainer('추가접종 : 1차 접종 후 2 ~ 4주 간격으로 2 ~ 3회'),
            _buildDogVaccineContainer('보강접종 : 추가접종 후 매년 1회 주사'),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.calendar_month),
              label: const Text('접종 시기 등록',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffE8DEF8),
                foregroundColor: Colors.grey.shade800,
                elevation: 0,
                fixedSize: const Size(double.maxFinite, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
        ExpansionTile(
          title: const Text('고양이 백혈병(Feline Leukemia)'),
          children: [
            _buildDogVaccineContainer('기초접종 : 생후 9 ~ 11주에 1차 접종'),
            _buildDogVaccineContainer('추가접종 : 1차 접종 후 2 ~ 4주 간격으로 1 ~ 2회'),
            _buildDogVaccineContainer('보강접종 : 추가접종 후 매년 1회 주사'),
          ],
        ),
        ExpansionTile(
          title: const Text('전염성 복막염(RP)'),
          children: [
            _buildDogVaccineContainer('추가접종 : 1차 접종 후 2 ~ 3주 간격으로 1회'),
            _buildDogVaccineContainer('보강접종 : 추가접종 후 매년 1회 주사'),
          ],
        ),
        ExpansionTile(
          title: const Text('광견병'),
          children: [
            _buildDogVaccineContainer('기초접종 : 생후 3개월 이상 1회 접종'),
            _buildDogVaccineContainer('보강접종 : 1개월 간격으로 주사'),
          ],
        ),
      ],
    );
  }

  Widget _buildDogVaccineContainer(String type) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey[200],
      child: Text(type),
    );
  }
}
