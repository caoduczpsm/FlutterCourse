
import 'package:flutter/material.dart';

class SignInform extends StatefulWidget{
  const SignInform({super.key});

  @override
  State<SignInform> createState() => _SignInFromState();
}

class _SignInFromState extends State<SignInform> {

  final _formKey = GlobalKey<FormState>();
  final userNameTerm = TextEditingController();
  final passwordTerm = TextEditingController();
  final confirmPasswordTerm = TextEditingController();
  final emailTerm = TextEditingController();

  bool isRemember = false;

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
                    style: textTitleActiveStyle,
                  ),
                  Text(
                    "Sign Up",
                    style: textTitleInActiveStyle,
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.remember_me),
                        const Text("Remember me", style: inputFontSize,),
                        Checkbox(
                          value: isRemember,
                          onChanged: (value) {
                            setState(() {
                              isRemember = value!;
                            });
                          },
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 50),
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
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}