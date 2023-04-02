abstract class Person {
  String? fullName;
  String? gender;
  String? phoneNumber;
  String? email;
  String? dateOfBirth;

  void purchaseParkingPass(String? name, String? gender, String? phoneNumber,
      String? email, String? dateOfBirth) {
    this.fullName = name;
    this.gender = gender;
    this.phoneNumber = phoneNumber;
    this.email = email;
    this.dateOfBirth = dateOfBirth;
  }
}
