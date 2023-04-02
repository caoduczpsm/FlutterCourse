import 'dart:io';

class Course {
  String? courseCode;
  String? name;
  double? duration;
  String? status;
  String? flag;

  void input() {
    // Nhập courseCode
    RegExp courseCodePattern = RegExp(r'^FW\d{3}$');
    do {
      print("Enter course code (start with FW và end with 3 digits): ");
      courseCode = stdin.readLineSync()!;
    } while (!courseCodePattern.hasMatch(courseCode!));

    // Nhập name
    print("Enter name: ");
    name = stdin.readLineSync()!;

    // Nhập duration
    do {
      print("Enter duration: ");
      duration = double.parse(stdin.readLineSync()!);
    } while (duration! <= 0);

    // Nhập status
    RegExp statusPattern = RegExp(r'^(active|in-active)$');
    do {
      print("Enter status (active or in-active): ");
      status = stdin.readLineSync()!;
    } while (!statusPattern.hasMatch(status!));

    // Nhập flag
    RegExp flagPattern = RegExp(r'^(optional|mandatory|NA)$');
    do {
      print("Enter flag (optional, mandatory or NA): ");
      flag = stdin.readLineSync()!;
    } while (!flagPattern.hasMatch(flag!));
  }

  void output() {
    print(
        "courseCode: $courseCode, name: $name, duration: $duration, status: $status, flag: $flag");
  }
}

void main() {
  List<Course> courses = [];

  //1
  for (int i = 0; i < 10; i++) {
    Course course = Course();
    course.input();
    courses.add(course);
  }

  for (int i = 0; i < courses.length; i++) {
    courses[i].output();
  }

  //2
  print("Enter type to search: ");
  String type = stdin.readLineSync()!;
  List<Course> results = search(type, courses);
  for (Course c in results) {
    c.output();
  }

  //3
  for (Course c in courses) {
    if (c.status == "mandatory") {
      c.output();
    }
  }
}

List<Course> search(String type, List<Course> courses) {
  List<Course> results = [];

  print("Enter keyword to search: ");
  String keyword = stdin.readLineSync()!;

  if (type == "code") {
    results = courses.where((course) => course.courseCode == keyword).toList();
  } else if (type == "name") {
    results = courses.where((course) => course.name == keyword).toList();
  } else if (type == "duration") {
    results = courses.where((course) => course.duration == keyword).toList();
  } else if (type == "flag") {
    results = courses.where((course) => course.flag == keyword).toList();
  } else if (type == "status") {
    results = courses.where((course) => course.status == keyword).toList();
  }
  return results;
}
