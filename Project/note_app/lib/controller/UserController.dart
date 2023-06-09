
import '../db/UserDatabase.dart';
import '../model/User.dart';


class UserController {

  bool checkValidEmail(String email){
    if (RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email) == true) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> register(String email, password) async{
    if (await UserSQLHelper.checkEmailAlreadyUsed(email)){
      User user = User(
        email: email,
        password: password,
      );
      UserSQLHelper.createUser(user);
      return true;
    }
    return false;
  }

  Future<int?> login(String email, String password) async{
    final user = await UserSQLHelper.getUserByEmailPassword(email, password);
    if (user != null){
      return user.id;
    } else {
      return null;
    }
  }
}