import 'dart:io';
import 'package:flutter/material.dart';
import 'package:note_app/form/NoteManagementApp.dart';
import 'package:note_app/model/User.dart';

import '../../controller/UserController.dart';
import '../../db/UserDatabase.dart';
import 'SignUp.dart';

void main() => runApp(const SignInForm());

class SignInForm extends StatelessWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: _MySignInForm(),
    );
  }
}

class _MySignInForm extends StatefulWidget {
  const _MySignInForm({Key? key}) : super(key: key);

  @override
  State<_MySignInForm> createState() => _MySignInFormState();
}

class _MySignInFormState extends State<_MySignInForm> {
  UserController userController = UserController();

  final _signInForm = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose(){
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note Management System'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          const Center(
            child: Text('Note Management System'
              ,style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),),
          ),
          const SizedBox(
            height: 30,
          ),
          Form(
            key: _signInForm,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value){
                    if (value == null || value.isEmpty){
                      return 'Please enter email';
                    }
                    return null;
                  },
                  controller: _email,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.key),
                  ),
                  validator: (value){
                    if (value == null || value.isEmpty){
                      return 'Please enter password';
                    }
                    return null;
                  },
                  controller: _password,
                  obscureText: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed:() async {
                        int? userID = await userController.login(_email.text.trim(), _password.text.trim());
                        if (userID !=null){
                          final user = await UserSQLHelper.getUserById(userID);
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Login Successful')));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              // Cái này chuyển đến dashboard khi login thành công
                              // Có thể thêm tham số userID khi chuyển trang để xử lý những dữ liệu khác khi cần user ID
                              builder: (context) => NoteManagementApp( user : user as User), // Ở đây
                            ),
                          );
                        } else {
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Invalid Email or Password')));
                        }
                      },
                      child: const Text('Login'),
                    ),
                    ElevatedButton(
                      onPressed:(){
                        exit(0);
                      },
                      child: const Text('Exit'),
                    )
                  ],
                )
              ],
            ),
          ),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const SignUpForm()));
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}


class PersonalInfoPage extends StatelessWidget {
  final dynamic user;

  const PersonalInfoPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text('ID: ${user.id}'),
            const SizedBox(height: 16.0),
            Text('Email: ${user.email}'),
            const SizedBox(height: 16.0),
            Text('Password: ${user.password}'),

          ],
        ),
      ),
    );
  }


}



