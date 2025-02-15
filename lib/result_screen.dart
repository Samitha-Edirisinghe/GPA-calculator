import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final double gpa;

  const ResultScreen({super.key, required this.gpa});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GPA Result')),
      body: Center(
        child: Text(
          'GPA: ${gpa.toStringAsFixed(2)}',
          style: TextStyle(fontSize: 24),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        child: Icon(Icons.arrow_back),
      ),
    );
  }
}
