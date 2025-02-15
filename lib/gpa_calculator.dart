// 22UG1-0791
// E.D.S.R.Edirisinghe
// CCS3351 Mobile Application Development Final project Q3. GPA-calculator

import 'package:final_project_q3/course.dart';

class GPACalculator {
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

  double calculateGPA(List<Course> courses) {
    double totalGP = 0;
    double totalCredits = 0;

    for (var course in courses) {
      final credit = double.tryParse(course.creditController.text);
      final grade = course.grade;

      if (credit == null || grade == null || grade.isEmpty) {
        throw Exception('Please fill all fields correctly');
      }

      final gp = gradeToGP[grade] ?? 0.0;
      totalGP += credit * gp;
      totalCredits += credit;
    }

    if (totalCredits == 0) {
      throw Exception('Total credits cannot be zero');
    }

    return totalGP / totalCredits;
  }
}
