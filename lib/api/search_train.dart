import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List<Station>> searchTrain(String trainNumber) async {
  var res = await http.get(
    Uri.parse(
        'https://www.irctc.co.in/eticketing/protected/mapps1/trnscheduleenquiry/$trainNumber'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'bmirak': 'webbm',
      'greq': '0'
    },
  );
  List<Station> stationList = [];
  Map<String, dynamic> data = jsonDecode(res.body);
  for (var station in data['stationList']) {
    stationList.add(Station(
        stnSerialNumber: station['stnSerialNumber'],
        stationCode: station['stationCode'],
        stationName: station['stationName']));
  }
  Map<String, int> map = Map();
  stationList.forEach((element) {
    // print(element.stnSerialNumber +
    //     ' ' +
    //     element.stationCode +
    //     ' ' +
    //     element.stationName);
    if (map.containsKey(element.stationCode)) {
      print(element.stationCode);
    }
    map[element.stationCode] = 1;
  });
  return stationList;
}

class Station {
  String stnSerialNumber;
  String stationCode;
  String stationName;
  Station(
      {required this.stnSerialNumber,
      required this.stationCode,
      required this.stationName});
}
