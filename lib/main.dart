import 'package:flutter/material.dart';
import 'input_screen.dart';

void main() {
  runApp(GPACalculatorApp());
}

class GPACalculatorApp extends StatelessWidget {
  const GPACalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GPA Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: InputScreen(),
    );
  }
}
