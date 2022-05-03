import 'dart:convert';

class OccupancyInfo {
  final int splitNo;
  final String from;
  final String to;
  final String quota;
  final bool occupancy;

  OccupancyInfo({
    required this.splitNo,
    required this.from,
    required this.to,
    required this.quota,
    required this.occupancy,
  });

  Map<String, dynamic> toMap() {
    return {
      'splitNo': splitNo,
      'from': from,
      'to': to,
      'quota': quota,
      'occupancy': occupancy,
    };
  }

  factory OccupancyInfo.fromMap(Map<String, dynamic> map) {
    return OccupancyInfo(
      splitNo: map['splitNo'],
      from: map['from'],
      to: map['to'],
      quota: map['quota'],
      occupancy: map['occupancy'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OccupancyInfo.fromJson(String source) =>
      OccupancyInfo.fromMap(json.decode(source));
}
