class Account{
  final int? id;
  final String? userName;
  final String? password;
  final String? email;
  final int? gender;

  Account({this.id, this.userName, this.password, this.email, this.gender});

  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'userName' : userName,
      'password' : password,
      'email' : email,
      'gender' : gender,
    };
  }
}