import 'dart:io';

void main() {
  int salary;
  String grade;

  print('Enter salary:');
  salary = int.parse(stdin.readLineSync()!);

  print('Enter grade:');
  grade = stdin.readLineSync()!;

  if (grade == 'A') {
    salary += 300;
  } else if (grade == 'B') {
    salary += 250;
  } else {
    salary += 100;
  }

  print('Salary = $salary');
}
