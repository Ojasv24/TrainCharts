import 'package:flutter/material.dart';
import 'package:train_charts/train_seat_json_edit/berth_info.dart';

class SeatListWidget extends StatelessWidget {
  final List<BerthInfo> berthInfo;
  const SeatListWidget({Key? key, required this.berthInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: berthInfo.length,
      itemBuilder: (context, index) {
        final currentBerthInfo = berthInfo[index];
        final occupancyInfo = currentBerthInfo.bsd;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          child: Card(
            color: Colors.white,
            elevation: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 8, top: 8),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6.0)),
                        color: Colors.blue[50],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          'Berth: ' +
                              currentBerthInfo.berthNo.toString() +
                              "(${currentBerthInfo.berthCode})",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...occupancyInfo.map((info) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5.0)),
                              border: Border.all(
                                width: 2,
                                color: info.occupancy
                                    ? Colors.redAccent
                                    : Colors.green,
                              ),
                            ),
                            // color: info.occupancy
                            //     ? Colors.redAccent
                            //     : Colors.green,
                            child: SizedBox(
                              width: 100,
                              height: 50,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    info.from + ' to ' + info.to,
                                    style: TextStyle(
                                        color: info.occupancy
                                            ? Colors.redAccent
                                            : Colors.green,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline),
                                  ),
                                  Text(
                                    info.occupancy ? 'Occupied' : 'Vacant',
                                    style: TextStyle(
                                      color: info.occupancy
                                          ? Colors.redAccent
                                          : Colors.green,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
