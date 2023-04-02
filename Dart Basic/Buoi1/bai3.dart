import 'dart:io';

void main() {
  int marks;
  String grade = "";
  print('Enter marks:');
  marks = int.parse(stdin.readLineSync()!);

  if (marks > 75) {
    grade = "A";
  } else if (marks < 75 && marks > 60) {
    grade = "B";
  } else if (marks < 60 && marks > 45) {
    grade = "C";
  } else if (marks < 45 && marks > 35) {
    grade = "D";
  } else {
    grade = "E";
  }

  print("grade: " + grade);
}
