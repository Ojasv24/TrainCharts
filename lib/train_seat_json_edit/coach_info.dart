import 'dart:convert';

import 'berth_info.dart';

class CoachInfo {
  final List<BerthInfo> bdd;
  final String coachName;
  final String? error;

  CoachInfo({
    required this.bdd,
    required this.coachName,
    required this.error,
  });

  Map<String, dynamic> toMap() {
    return {
      'bdd': bdd.map((x) => x.toMap()).toList(),
      'coachName': coachName,
      'error': error,
    };
  }

  factory CoachInfo.fromMap(Map<String, dynamic> map) {
    return CoachInfo(
      bdd: List<BerthInfo>.from(map['bdd']?.map((x) => BerthInfo.fromMap(x))),
      coachName: map['coachName'],
      error: map['error'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CoachInfo.fromJson(String source) =>
      CoachInfo.fromMap(json.decode(source));
}
