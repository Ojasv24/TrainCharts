import 'package:flutter/material.dart';

class InvalidDataWidget extends StatelessWidget {
  final String invalidMessage;
  const InvalidDataWidget({Key? key, required this.invalidMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Invalid Data",
        style: TextStyle(
          color: Colors.red,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
