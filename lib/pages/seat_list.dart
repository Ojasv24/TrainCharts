import 'package:flutter/material.dart';
import 'package:train_charts/info.dart';
import 'package:http/http.dart' as http;
import 'package:train_charts/pdf_maker/create_pdf.dart';
import 'package:train_charts/train_seat_json_edit/coach_info.dart';
import 'package:train_charts/widget/invalid_data_widget.dart';
import 'package:train_charts/widget/seat_list_widget.dart';

class SeatList extends StatelessWidget {
  final Info info;
  const SeatList({Key? key, required this.info}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seats'),
        elevation: 1,
      ),
      body: info.isComplete()
          ? FutureBuilder<http.Response>(
              future: http.post(
                Uri.parse(
                    'https://www.irctc.co.in/online-charts/api/coachComposition'),
                headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                },
                body: info.toJson(),
              ),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const InvalidDataWidget(
                    invalidMessage: 'Invalid Data',
                  );
                }
                if (snapshot.hasData) {
                  final body = snapshot.data!.body;
                  final coachInfo = CoachInfo.fromJson(body);
                  final berthInfo = coachInfo.bdd;
                  if (berthInfo.isEmpty) {
                    return const InvalidDataWidget(
                      invalidMessage: 'Invalid Data',
                    );
                  }
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                createPDF(coachInfo);
                              },
                              child: const Text('Download PDF'),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: SeatListWidget(
                          berthInfo: berthInfo,
                        ),
                      ),
                    ],
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Text(snapshot.connectionState.toString());
                }
              },
            )
          : const InvalidDataWidget(
              invalidMessage: 'Fill all fields',
            ),
    );
  }
}
