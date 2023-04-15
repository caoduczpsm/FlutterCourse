
import 'package:flutter/material.dart';

class SignUpform extends StatefulWidget{
  const SignUpform({super.key});

  @override
  State<SignUpform> createState() => _SignUpFromState();
}

class _SignUpFromState extends State<SignUpform> {

  final _formKey = GlobalKey<FormState>();
  final userNameTerm = TextEditingController();
  final passwordTerm = TextEditingController();
  final confirmPasswordTerm = TextEditingController();
  final emailTerm = TextEditingController();
  int gender = 0;

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
                        icon: Icon(Icons.supervised_user_circle),
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
                        icon: Icon(Icons.password_rounded),
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
                        icon: Icon(Icons.password_sharp),
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
                        icon: Icon(Icons.email),
                        border: UnderlineInputBorder(),
                        hintText: 'Email',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: ElevatedButton(
                        onPressed: () {
                          if(_formKey.currentState!.validate()){
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('Processing Data'),
                            ));
                          }
                        },
                        child: const Text('Sign In'),
                      ),
                    ),
                  ],
                ),
              ),
              // Row(
              //   children: [
              //     RadioListTile(
              //       title: const Text('Male'),
              //       value: 0,
              //       groupValue: gender,
              //       onChanged: (value) {
              //         setState(() {
              //           gender = int.parse(value.toString());
              //         });
              //       },
              //     ),
              //     RadioListTile(
              //       title: const Text('Male'),
              //       value: 1,
              //       groupValue: gender,
              //       onChanged: (value) {
              //         setState(() {
              //           gender = int.parse(value.toString());
              //         });
              //       },
              //     )
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }

}