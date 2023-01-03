import 'package:flutter/material.dart';
import 'package:train_charts/api/coach_list_info.dart';
import 'package:train_charts/api/search_train.dart';
import 'package:train_charts/pages/coach_list.dart';

class SelectTrain extends StatefulWidget {
  const SelectTrain({Key? key}) : super(key: key);

  @override
  _SelectTrainState createState() => _SelectTrainState();
}

class _SelectTrainState extends State<SelectTrain> {
  DateTime selectedDate = DateTime.now();
  final _trainNumberController = TextEditingController();
  final _dateController = TextEditingController();
  var _sourceStation = '';
  List<Station> stationList = [];
  // ignore: prefer_typing_uninitialized_variables
  var _boardingStation = '';
  var _validTrain = true;

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
        title: Row(
          children: const [
            Icon(Icons.train_rounded),
            SizedBox(
              width: 6,
            ),
            Text("Choose Train"),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 8,
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: _trainNumberController,
              decoration: InputDecoration(
                label: const Text('Train Number'),
                border: const OutlineInputBorder(),
                errorText: !_validTrain ? 'Invalid Train Number' : null,
              ),
              onChanged: (value) async {
                if (value.length == 5) {
                  try {
                    final x = await searchTrain(_trainNumberController.text);

                    setState(() {
                      _validTrain = true;
                      stationList = x;
                      _boardingStation = stationList.first.stationCode;
                    });
                  } catch (e) {
                    setState(() {
                      _validTrain = false;
                      stationList = [];
                    });
                  }
                }
              },
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: DropdownButton(
                menuMaxHeight: 400,
                focusColor: Colors.grey,
                hint: const Text("Boarding Station"),
                value: stationList.isEmpty ? null : _boardingStation,
                // icon: const Icon(Icons.arrow_downward),
                isExpanded: true,

                // elevation: 16,
                items: stationList.map<DropdownMenuItem<String>>((value) {
                  return DropdownMenuItem<String>(
                    value: value.stationCode,
                    child: Text("${value.stationName} (${value.stationCode})"),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _boardingStation = value!;
                  });
                },
                // icon: Icon(Icons.arrow_drop_down),
                // iconSize: 10,
                underline: const SizedBox(),
              ),
            ),
            Center(
                child: ElevatedButton(
                    onPressed: () async {
                      try {
                        final x = await getCoachlist(_boardingStation,
                            selectedDate, _trainNumberController.text);
                        for (Station s in stationList) {
                          if (x.boardingStation == s.stationCode) {
                            x.boardingStationName = s.stationName;
                          }
                          if (x.chartingStation == s.stationCode) {
                            x.chartingStationName = s.stationName;
                          }
                          if (x.trainSourceStation == s.stationCode) {
                            x.trainSourceStationName = s.stationName;
                          }
                        }

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CoachList(
                                      coachInfo: x,
                                    )));
                      } catch (e) {
                        final snackBar = SnackBar(
                          content: Text(e.toString()),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: const Text('Get Train Charts')))
          ],
        ),
      ),
    );
  }
}
