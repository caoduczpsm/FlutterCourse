import 'Person.dart';
import 'dart:io';
import 'Student.dart';
import 'Teacher.dart';

List<Person> persons = [];
void main() {
  //1
  for (int i = 0; i < 5; i++) {
    String type;
    print("Nhập tên: ");
    String name = stdin.readLineSync()!;
    print("Nhập giới tính: ");
    String gender = stdin.readLineSync()!;
    print("Nhập số điện thoại: ");
    String phoneNumber = stdin.readLineSync()!;
    print("Nhập email: ");
    String email;

    RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    do {
      email = stdin.readLineSync()!;
    } while (!emailRegExp.hasMatch(email));

    print("Nhập ngày sinh: ");

    String date;
    RegExp dateRegExp = RegExp(r'^\d{2}\/\d{2}\/\d{4}$');

    do {
      date = stdin.readLineSync()!;
    } while (!dateRegExp.hasMatch(date));

    do {
      print('Student nhập 1, Teacher nhập 2');
      type = stdin.readLineSync()!;
    } while (!(type != "1" || type != "2"));

    if (type == "1") {
      Student student = Student();
      double theory;
      double practice;

      print('Nhập student Id:');
      String studentId = stdin.readLineSync()!;

      do {
        print('Nhập điểm lý thuyết (từ 0 đến 10):');
        theory = double.parse(stdin.readLineSync()!);
        if (!isBetween(theory)) {
          print('Giá trị không hợp lệ!');
        }
      } while (!isBetween(theory));

      do {
        print('Nhập điểm thực hànhA (từ 0 đến 10):');
        practice = double.parse(stdin.readLineSync()!);
        if (!isBetween(practice)) {
          print('Giá trị không hợp lệ!');
        }
      } while (!isBetween(practice));

      student.purchaseParkingPass(name, gender, phoneNumber, email, date);
      student.input(studentId, theory, practice);
      persons.add(student);
    } else {
      Teacher teacher = Teacher();
      print('Nhập lương:');
      double bassicSalary = double.parse(stdin.readLineSync()!);
      print('Nhập trợ cấp:');
      double subidy = double.parse(stdin.readLineSync()!);
      teacher.input(bassicSalary, subidy);
      teacher.purchaseParkingPass(name, gender, phoneNumber, email, date);
      persons.add(teacher);
    }
  }

  print("//////////////////////// 2 /////////////////////////");
  //2
  String studentIdToUpdate = stdin.readLineSync()!;
  Student updateResult = updateStudentByID(studentIdToUpdate);
  updateResult.display();

  //3
  print("//////////////////////// 3 /////////////////////////");
  List<Teacher> teachers = getTeacherHaveSalaryGreaterThan1000();
  for (Teacher teacher in teachers) {
    teacher.display();
  }

  //4
  print("//////////////////////// 4 /////////////////////////");
  List<Student> students = getStudentPassCourse();
  for (Student student in students) {
    student.display();
  }
}

bool isBetween(double number) {
  return number >= 0 && number <= 10;
}

Student updateStudentByID(String id) {
  Student result = Student();
  for (Person person in persons) {
    if (person is Student) {
      if (person.studentId == id) {
        double theory;
        double practice;

        print('Nhập student Id:');
        String studentId = stdin.readLineSync()!;

        do {
          print('Nhập điểm lý thuyết (từ 0 đến 10):');
          theory = double.parse(stdin.readLineSync()!);
          if (!isBetween(theory)) {
            print('Giá trị không hợp lệ!');
          }
        } while (!isBetween(theory));

        do {
          print('Nhập điểm thực hànhA (từ 0 đến 10):');
          practice = double.parse(stdin.readLineSync()!);
          if (!isBetween(practice)) {
            print('Giá trị không hợp lệ!');
          }
        } while (!isBetween(practice));

        result.purchaseParkingPass(person.fullName, person.gender,
            person.phoneNumber, person.email, person.dateOfBirth);
        persons.remove(person);
        result.input(studentId, theory, practice);
        persons.add(result);
        break;
      }
    }
  }
  return result;
}

List<Teacher> getTeacherHaveSalaryGreaterThan1000() {
  List<Teacher> result = [];
  for (Person person in persons) {
    if (person is Teacher) {
      if (person.calculateSalry() > 1000) {
        result.add(person);
      }
    }
  }
  return result;
}

List<Student> getStudentPassCourse() {
  List<Student> result = [];
  for (Person person in persons) {
    if (person is Student) {
      if (person.calculateFinalMark() > 6) {
        result.add(person);
      }
    }
  }
  return result;
}
