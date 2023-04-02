import 'Person.dart';

class Teacher extends Person {
  double? bassicSalary;
  double? subidy;

  double calculateSalry() {
    return bassicSalary! + subidy!;
  }

  void input(double bassicSalary, double subidy) {
    this.bassicSalary = bassicSalary;
    this.subidy = subidy;
  }

  void display() {
    print(
        "$fullName - $email - $gender - $phoneNumber - $bassicSalary - $subidy");
  }
}
