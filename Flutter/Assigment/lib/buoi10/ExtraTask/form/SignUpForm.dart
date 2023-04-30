
import 'package:buoi_4_bai_1/buoi10/ExtraTask/db/sql_helper.dart';
import 'package:buoi_4_bai_1/buoi10/ExtraTask/model/account.dart';
import 'package:flutter/material.dart';

class SignUpform extends StatefulWidget{
  const SignUpform({super.key});

  @override
  State<SignUpform> createState() => _SignUpFromState();
}

enum GenderCharacter {male, female}

class _SignUpFromState extends State<SignUpform> {

  List<Map<String, dynamic>> accounts = [];

  final _formKey = GlobalKey<FormState>();
  final userNameTerm = TextEditingController();
  final passwordTerm = TextEditingController();
  final confirmPasswordTerm = TextEditingController();
  final emailTerm = TextEditingController();
  String gender = "";

  late GenderCharacter _genderCharacter;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    userNameTerm.dispose();
    passwordTerm.dispose();
    confirmPasswordTerm.dispose();
    emailTerm.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _genderCharacter = GenderCharacter.male;
  }

  @override
  Widget build(BuildContext context) {

    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    const textTitleInActiveStyle = TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24
    );

    const textTitleActiveStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 24,
      color: Colors.blueAccent,
    );

    const inputFontSize = TextStyle(
        fontSize: 20
    );

    return Center(
      child: Container(
        padding: const EdgeInsets.all(10),
        width: width * 0.85,
        height: height * 0.5,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 8, spreadRadius: 5)
            ]
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Text(
                    "Sign In",
                    style: textTitleInActiveStyle,
                  ),
                  Text(
                    "Sign Up",
                    style: textTitleActiveStyle,
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    TextFormField(
                      style: inputFontSize,
                      controller: userNameTerm,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.supervised_user_circle),
                        border: UnderlineInputBorder(),
                        hintText: 'User name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      style: inputFontSize,
                      controller: passwordTerm,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.password_rounded),
                        border: UnderlineInputBorder(),
                        hintText: 'Password',
                      ),
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      style: inputFontSize,
                      controller: confirmPasswordTerm,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.password_sharp),
                        border: UnderlineInputBorder(),
                        hintText: 'Confirm password',
                      ),
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      style: inputFontSize,
                      controller: emailTerm,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        border: UnderlineInputBorder(),
                        hintText: 'Email',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        if(!emailRegExp.hasMatch(value)){
                          return 'Please enter email form';
                        }
                        return null;
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile(
                            title: const Text('Male'),
                            value: GenderCharacter.male,
                            groupValue: _genderCharacter,
                            onChanged: (GenderCharacter? value) {
                              setState(() {
                                _genderCharacter = value!;
                                gender = 'Male';
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            title: const Text('Female'),
                            value: GenderCharacter.female,
                            groupValue: _genderCharacter,
                            onChanged: (GenderCharacter? value) {
                              setState(() {
                                _genderCharacter = value!;
                                gender = 'Female';
                              });
                            },
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          if(_formKey.currentState!.validate()){
                            _addAccount();
                          }
                        },
                        child: const Text('Sign In'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _addAccount() async{
    int? id = await SQLHelper.createAccount(Account(
        userName: userNameTerm.text,
        password: passwordTerm.text,
        email: emailTerm.text,
        gender: gender == 'Male' ? 1 : 0
    ));

    if(!mounted) return;

      if(id == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Regis Fail'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Regis Successfully'),
          ),
        );
      }
      userNameTerm.text = "";
      passwordTerm.text = "";
      emailTerm.text = "";
      _genderCharacter = GenderCharacter.male;
      confirmPasswordTerm.text = "";
  }

}