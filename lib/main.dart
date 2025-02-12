// 22UG1-0791
// E.D.S.R.Edirisinghe
// CCS3351 Mobile Application Development Final project Q3. GPA calculator

import 'package:flutter/material.dart';

void main() {
  runApp(GPACalculatorApp());
}

class GPACalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GPA Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: InputScreen(),
    );
  }
}

class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final List<Course> _courses = [Course()];
  final Map<String, double> gradeToGP = {
    'A+': 4.0,
    'A': 4.0,
    'A-': 3.7,
    'B+': 3.3,
    'B': 3.0,
    'B-': 2.7,
    'C+': 2.3,
    'C': 2.0,
    'C-': 1.7,
    'D+': 1.3,
    'D': 1.0,
    'E (30-34)': 0.7,
    'E (0-29)': 0.0,
  };

  void _addCourse() {
    setState(() {
      _courses.add(Course());
    });
  }

  void _calculateGPA() {
    double totalGP = 0;
    double totalCredits = 0;

    for (var course in _courses) {
      final credit = double.tryParse(course.creditController.text);
      final grade = course.grade;

      if (credit == null || grade == null || grade.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please fill all fields correctly')),
        );
        return;
      }

      final gp = gradeToGP[grade] ?? 0.0;
      totalGP += credit * gp;
      totalCredits += credit;
    }

    if (totalCredits == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Total credits cannot be zero')),
      );
      return;
    }

    final gpa = totalGP / totalCredits;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(gpa: gpa),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GPA Calculator')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              ..._courses.map((course) => _buildCourseRow(course)).toList(),
              ElevatedButton(
                onPressed: _addCourse,
                child: Text('Add Course'),
              ),
              ElevatedButton(
                onPressed: _calculateGPA,
                child: Text('Calculate GPA'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCourseRow(Course course) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: course.nameController,
            decoration: InputDecoration(labelText: 'Course Name'),
          ),
        ),
        Expanded(
          child: TextField(
            controller: course.creditController,
            decoration: InputDecoration(labelText: 'Credit'),
            keyboardType: TextInputType.number,
          ),
        ),
        Expanded(
          child: DropdownButtonFormField<String>(
            value: course.grade,
            items: gradeToGP.keys.map((String grade) {
              return DropdownMenuItem<String>(
                value: grade,
                child: Text(grade),
              );
            }).toList(),
            onChanged: (value) => setState(() => course.grade = value),
            decoration: InputDecoration(labelText: 'Grade'),
          ),
        ),
      ],
    );
  }
}

class Course {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController creditController = TextEditingController();
  String? grade;
}

class ResultScreen extends StatelessWidget {
  final double gpa;

  ResultScreen({required this.gpa});

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
