class ProfileData {
  final String? id;
  final String? email;
  final String? name;
  final String? age;

  ProfileData({this.id, this.email, this.name, this.age});

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
        id: json['id'], email: json['email'],
        name: json['name'], age: json['age']
    );
  }
}