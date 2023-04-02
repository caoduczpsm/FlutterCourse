class Patient {
  String? name;
  int? age;
  String? disease;

  Patient(this.name, this.age, this.disease);

  void display() {
    print("$name - $age - $disease");
  }
}

void main() {
  Patient patient = Patient("name", 55, "disease");
  patient.display();
}
