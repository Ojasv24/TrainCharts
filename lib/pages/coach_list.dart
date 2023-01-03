import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:train_charts/api/coach_list_info.dart';
import 'package:train_charts/pages/seat_list.dart';
import 'package:train_charts/widget/name_wdiget.dart';

import '../info.dart';

class CoachList extends StatelessWidget {
  final CoachListInfo coachInfo;
  const CoachList({Key? key, required this.coachInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Icon(Icons.table_chart_rounded),
            SizedBox(
              width: 6,
            ),
            Text("Coach List"),
          ],
        ),
      ),
      body: Column(
        children: [
          Card(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                NameWidget(first: "Train Name", second: coachInfo.trainName),
                NameWidget(first: "Train No", second: coachInfo.trainNo),
                NameWidget(
                    first: "Date",
                    second: DateFormat('yyyy-MM-dd').format(coachInfo.jDate)),
                NameWidget(
                    first: "Boarding Station",
                    second: coachInfo.boardingStationName),
                NameWidget(
                    first: "Charting Station",
                    second: coachInfo.chartingStationName),
                NameWidget(
                    first: "Source Station",
                    second: coachInfo.trainSourceStationName),
              ],
            ),
          )),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                height: 2,
                thickness: 2,
                indent: 14,
                endIndent: 14,
              ),
              itemCount: coachInfo.coachList.length,
              itemBuilder: (context, index) {
                final coachList = coachInfo.coachList;
                print(coachList.length);
                var borderRadius = const BorderRadius.only(
                    topRight: Radius.circular(32),
                    bottomRight: Radius.circular(32));
                return ListTile(
                  title: Row(
                    children: [
                      Text(coachList[index].coachName),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        "(${coachList[index].classCode})",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SeatList(
                                info: Info(
                                  trainNumber: coachInfo.trainNo,
                                  boardingStationCode:
                                      coachInfo.boardingStation,
                                  chartingStation: coachInfo.chartingStation,
                                  coach: coachList[index].coachName,
                                  coachClass: coachList[index].classCode,
                                  date: coachInfo.jDate,
                                  sourceStationCode:
                                      coachInfo.trainSourceStation,
                                ),
                              )),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
