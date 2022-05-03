import 'package:flutter/material.dart';
import 'package:train_charts/info.dart';
import 'package:train_charts/pages/seat_list.dart';

class SelectTrain extends StatefulWidget {
  const SelectTrain({Key? key}) : super(key: key);

  @override
  _SelectTrainState createState() => _SelectTrainState();
}

class _SelectTrainState extends State<SelectTrain> {
  DateTime selectedDate = DateTime.now();
  final _trainNumberController = TextEditingController();
  final _dateController = TextEditingController();
  final _boardingStationCodeController = TextEditingController();
  final _chartingStationController = TextEditingController();
  final _sourceStationCodeController = TextEditingController();
  final _coachController = TextEditingController();
  final _classController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _dateController.text = selectedDate.day.toString() +
            '/' +
            selectedDate.month.toString() +
            '/' +
            selectedDate.year.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Train"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: [
            const SizedBox(
              height: 8,
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: _trainNumberController,
              decoration: const InputDecoration(
                label: Text('Train Number'),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              controller: _dateController,
              enableInteractiveSelection: false,
              decoration: const InputDecoration(
                label: Text('Date'),
                border: OutlineInputBorder(),
              ),
              onTap: () {
                _selectDate(context);
              },
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              textCapitalization: TextCapitalization.characters,
              controller: _boardingStationCodeController,
              decoration: const InputDecoration(
                label: Text('Boarding station code'),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              textCapitalization: TextCapitalization.characters,
              controller: _chartingStationController,
              decoration: const InputDecoration(
                label: Text('Charting Station'),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              textCapitalization: TextCapitalization.characters,
              controller: _sourceStationCodeController,
              decoration: const InputDecoration(
                label: Text('Source station code'),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              textCapitalization: TextCapitalization.characters,
              controller: _coachController,
              decoration: const InputDecoration(
                label: Text('Coach'),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              textCapitalization: TextCapitalization.characters,
              controller: _classController,
              decoration: const InputDecoration(
                label: Text('Class'),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SeatList(
                      info: Info(
                        trainNumber: _trainNumberController.text,
                        boardingStationCode:
                            _boardingStationCodeController.text,
                        chartingStation: _chartingStationController.text,
                        coach: _coachController.text,
                        coachClass: _classController.text,
                        date: selectedDate,
                        sourceStationCode: _sourceStationCodeController.text,
                      ),
                    )),
          );
        },
        child: const Icon(Icons.arrow_right_alt_rounded),
      ),
    );
  }
}
