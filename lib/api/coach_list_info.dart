import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

Future<CoachListInfo> getCoachlist(
    String boardingStation, DateTime jDate, String trainNo) async {
  final payload = {
    "trainNo": trainNo,
    "jDate": DateFormat('yyyy-MM-dd').format(jDate),
    "boardingStation": boardingStation
  };
  print(payload);
  var res = await http.post(
    Uri.parse('https://www.irctc.co.in/online-charts/api/trainComposition'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: json.encode(payload),
  );
  List<Coach> coachList = [];
  Map<String, dynamic> data = jsonDecode(res.body);
  print(data);
  if (data['error'] != null) {
    throw Exception(data['error']);
  }

  for (var coach in data['cdd']) {
    coachList.add(
        Coach(classCode: coach['classCode'], coachName: coach['coachName']));
  }

  return CoachListInfo(
    boardingStation: boardingStation,
    chartingStation: data['remote'],
    coachList: coachList,
    jDate: jDate,
    trainName: data['trainName'],
    trainNo: trainNo,
    trainSourceStation: data['from'],
    boardingStationName: '',
    chartingStationName: '',
    trainSourceStationName: '',
  );
}

class CoachListInfo {
  String trainNo;
  String trainName;
  String boardingStation;
  String chartingStation;
  String boardingStationName;
  String chartingStationName;
  String trainSourceStation;
  String trainSourceStationName;
  DateTime jDate;
  List<Coach> coachList;
  CoachListInfo({
    required this.boardingStation,
    required this.chartingStation,
    required this.coachList,
    required this.jDate,
    required this.trainName,
    required this.trainNo,
    required this.trainSourceStation,
    required this.boardingStationName,
    required this.chartingStationName,
    required this.trainSourceStationName,
  });
}

class Coach {
  String coachName;
  String classCode;

  Coach({required this.classCode, required this.coachName});
}
