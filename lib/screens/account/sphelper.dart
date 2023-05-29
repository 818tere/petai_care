import 'package:shared_preferences/shared_preferences.dart';
import 'performance.dart';
import 'dart:convert';

class SPHelper {
  static SharedPreferences? prefs;
  Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future writePerformance(Performance performance) async {
    await prefs?.setString(
        performance.id.toString(), json.encode(performance.toJson()));
  }

  List<Performance> readPerformances() {
    List<Performance> performances = [];
    Set<String>? keys = prefs?.getKeys(); //SharedPreferences에 저장한 모든 키 가져오기
    for (var key in keys?.toList() ?? []) {
      if (key != 'counter') {
        Performance performance =
            Performance.fromJson(json.decode(prefs?.getString(key) ?? ''));
        performances.add(performance);
      }
    }
    return performances;
  }

  Future deletePerformance(int id) async {
    await prefs?.remove(id.toString());
  }

  Future setCounter() async {
    int counter = prefs?.getInt('counter') ?? 0;
    counter++;
    await prefs?.setInt('counter', counter);
  } //ID 관리

  int getCounter() {
    return prefs?.getInt('counter') ?? 0;
  }
}
