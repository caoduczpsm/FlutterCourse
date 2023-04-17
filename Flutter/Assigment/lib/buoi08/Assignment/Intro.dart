import 'package:flutter/material.dart';

class Intro extends StatelessWidget{
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: buildHomePage(),
    );
  }

  Widget buildHomePage(){
    return Scaffold(
      appBar: AppBar(title: const Text('Introduction Forms'),),
      body: const MyCustomForm(),
    );
  }
}

class MyCustomForm extends StatefulWidget{
  const MyCustomForm({super.key});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();

}

enum GenderCharacter {male, female}

class _MyCustomFormState extends State<MyCustomForm>{

  final _formKey = GlobalKey<FormState>();
  final searchTerm = TextEditingController();

  var orderBy = "";
  String _gender = "";
  late GenderCharacter _genderCharacter;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _genderCharacter = GenderCharacter.male;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchTerm.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: searchTerm,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter a search term'
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: (){
              if(_formKey.currentState!.validate()){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Your Information with Name ${searchTerm.text}, Gender: ${_gender}' ),
                ));
              }
            },
            child: const Text('Submit'),
          ),
          RadioListTile(
            title: const Text('Male'),
            value: GenderCharacter.male,
            groupValue: _genderCharacter,
            onChanged: (GenderCharacter ? value) {
              setState(() {
                _genderCharacter = value!;
                _gender = GenderCharacter.male.name;
              });
            },
          ),
          RadioListTile(
            title: const Text('Female'),
            value: GenderCharacter.female,
            groupValue: _genderCharacter,
            onChanged: (GenderCharacter ? value) {
              setState(() {
                _genderCharacter = value!;
                _gender = GenderCharacter.female.name;
              });
            },
          )
        ],
      ),
    );
  }
}