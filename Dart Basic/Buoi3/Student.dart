import 'Person.dart';

class Student extends Person {
  String? studentId;
  double? theory;
  double? practice;

  double calculateFinalMark() {
    return (theory! + practice!) / 2;
  }

  void input(String? studentId, double? theory, double? practice) {
    this.theory = theory;
    this.practice = practice;
    this.studentId = studentId;
  }

  void display() {
    print("$fullName - $email - $gender - $phoneNumber - $theory - $practice");
  }
}
