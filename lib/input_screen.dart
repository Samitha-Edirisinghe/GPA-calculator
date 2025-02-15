import 'package:flutter/material.dart';
import 'course.dart';
import 'gpa_calculator.dart';
import 'result_screen.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final List<Course> _courses = [Course()];
  final GPACalculator _gpaCalculator = GPACalculator();

  void _addCourse() {
    setState(() {
      _courses.add(Course());
    });
  }

  void _calculateGPA() {
    try {
      final gpa = _gpaCalculator.calculateGPA(_courses);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(gpa: gpa),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
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
              ..._courses.map((course) => _buildCourseRow(course)),
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
            items: _gpaCalculator.gradeToGP.keys.map((String grade) {
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
