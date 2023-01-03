import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'occupancy_info.dart';

class BerthInfo {
  final String? cabinCoupe;
  final String cabinCoupeNameNo;
  String berthCode;
  final int berthNo;
  final String from;
  final String to;
  final List<OccupancyInfo> bsd;
  final String? quotaCntStn;
  final bool enable;

  BerthInfo({
    required this.cabinCoupe,
    required this.cabinCoupeNameNo,
    required this.berthCode,
    required this.berthNo,
    required this.from,
    required this.to,
    required this.bsd,
    required this.quotaCntStn,
    required this.enable,
  });

  Map<String, dynamic> toMap() {
    return {
      'cabinCoupe': cabinCoupe,
      'cabinCoupeNameNo': cabinCoupeNameNo,
      'berthCode': berthCode,
      'berthNo': berthNo,
      'from': from,
      'to': to,
      'bsd': bsd.map((x) => x.toMap()).toList(),
      'quotaCntStn': quotaCntStn,
      'enable': enable,
    };
  }

  factory BerthInfo.fromMap(Map<String, dynamic> map) {
    return BerthInfo(
      cabinCoupe: map['cabinCoupe'],
      cabinCoupeNameNo: map['cabinCoupeNameNo'],
      berthCode: map['berthCode'],
      berthNo: map['berthNo'],
      from: map['from'],
      to: map['to'],
      bsd: List<OccupancyInfo>.from(
          map['bsd']?.map((x) => OccupancyInfo.fromMap(x))),
      quotaCntStn: map['quotaCntStn'],
      enable: map['enable'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BerthInfo.fromJson(String source) =>
      BerthInfo.fromMap(json.decode(source));

  @override
  int get hashCode {
    return cabinCoupe.hashCode ^
        cabinCoupeNameNo.hashCode ^
        berthCode.hashCode ^
        berthNo.hashCode ^
        from.hashCode ^
        to.hashCode ^
        bsd.hashCode ^
        quotaCntStn.hashCode ^
        enable.hashCode;
  }
}
