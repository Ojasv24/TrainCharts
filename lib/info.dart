import 'dart:convert';

import 'package:intl/intl.dart';

class Info {
  final String trainNumber;
  final DateTime date;
  final String boardingStationCode;
  final String chartingStation;
  final String sourceStationCode;
  final String coach;
  final String coachClass;

  Info({
    required this.trainNumber,
    required this.date,
    required this.boardingStationCode,
    required this.chartingStation,
    required this.sourceStationCode,
    required this.coach,
    required this.coachClass,
  });

  bool isComplete() {
    if (trainNumber.isEmpty ||
        boardingStationCode.isEmpty ||
        chartingStation.isEmpty ||
        sourceStationCode.isEmpty ||
        coach.isEmpty ||
        coachClass.isEmpty) {
      return false;
    }
    return true;
  }

  Map<String, dynamic> toMap() {
    return {
      'trainNo': trainNumber,
      'jDate': DateFormat('yyyy-MM-dd').format(date),
      'boardingStation': boardingStationCode,
      'remoteStation': chartingStation,
      'trainSourceStation': sourceStationCode,
      'coach': coach,
      'cls': coachClass,
    };
  }

  factory Info.fromMap(Map<String, dynamic> map) {
    return Info(
      trainNumber: map['trainNo'],
      date: map['jDate'],
      boardingStationCode: map['boardingStation'],
      chartingStation: map['remoteStation'],
      sourceStationCode: map['trainSourceStation'],
      coach: map['coach'],
      coachClass: map['cls'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Info.fromJson(String source) => Info.fromMap(json.decode(source));
}
