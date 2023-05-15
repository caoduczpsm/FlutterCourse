class Trainee {
  final String? id;
  final String? phone;
  final String? email;
  final String? name;
  final String? gender;

  Trainee({this.id, this.phone, this.email, this.name, this.gender});

  factory Trainee.fromJson(Map<String, dynamic> json) {
    return Trainee(
        id: json['id'], phone: json['phone'], email: json['email'],
        name: json['name'], gender: json['gender']
    );
  }
}