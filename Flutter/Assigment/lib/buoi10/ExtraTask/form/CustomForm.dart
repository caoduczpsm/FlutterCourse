import 'package:buoi_4_bai_1/buoi10/ExtraTask/form/SignInForm.dart';
import 'package:buoi_4_bai_1/buoi10/ExtraTask/form/SignUpForm.dart';
import 'package:flutter/material.dart';

class CustomForm extends StatelessWidget {
  const CustomForm({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: buildHomePage(),
    );
  }

  Widget buildHomePage() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Introduction Forms'),
      ),
      body: const MyCustomForm(),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

enum OrderCharacter { ascending, descending }

class _MyCustomFormState extends State<MyCustomForm> {

  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Stack(
      children: <Widget>[
        Container(
          width: width,
          height: height,
          color: Colors.grey[100],
        ),
        GestureDetector(
          onHorizontalDragStart: (DragStartDetails details){
            setState(() {
              isLogin = !isLogin;
            });
          },

          child: (isLogin) ? const SignInform() : const SignUpform(),
        ),
      ],
    );
  }
}
