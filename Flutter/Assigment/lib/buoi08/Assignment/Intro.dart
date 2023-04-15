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

enum OrderCharacter {ascending, descending}

class _MyCustomFormState extends State<MyCustomForm>{

  final _formKey = GlobalKey<FormState>();
  final searchTerm = TextEditingController();

  var orderBy = "";
  OrderCharacter _orderCharacter = OrderCharacter.ascending;

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
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Processing Data'),
                ));
              }
            },
            child: const Text('Submit'),
          ),
          CheckboxListTile(
            title: const Text('Asc'),
            secondary: const Icon(Icons.onetwothree_rounded),
            value: false,
            onChanged: (value) {
              setState(() {

              });
            },
          ),
          RadioListTile(
            title: const Text('Ascending'),
            value: OrderCharacter.ascending,
            groupValue: _orderCharacter,
            onChanged: (OrderCharacter? value) {
              setState(() {
                _orderCharacter = value!;
                orderBy = OrderCharacter.ascending.name;
              });
            },
          )
        ],
      ),
    );
  }
}