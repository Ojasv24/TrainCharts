import 'package:flutter/material.dart';

class NameWidget extends StatelessWidget {
  const NameWidget({Key? key, required this.first, required this.second})
      : super(key: key);
  final first;
  final second;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          first + ': ',
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        Text(
          second,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
