import 'package:flutter/material.dart';

class GetCheckBok extends StatelessWidget{
  const GetCheckBok({super.key});

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

class _MyCustomFormState extends State<MyCustomForm>{

  final _formKey = GlobalKey<FormState>();
  List<String> fruits = [];
  String message = "";

  Map<String, bool> fruitsMap = {
    "Apple" : false,
    "Banana" : false,
    "Cherry" : false,
    "Mango" : false,
    "Orange" : false
  };

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Form(
      key: _formKey,
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            ElevatedButton(
              onPressed: (){
                if(_formKey.currentState!.validate()){

                    fruitsMap.forEach((key, value) {
                      if(value){
                        message = "$message $key ";
                        fruits.add(key);
                      }
                    });
                    if(fruits.isEmpty){
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Please select one"),
                      ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(message),
                      ));
                      fruits.clear();
                    }
                }
              },
              child: const Text('Get Selected Checkbox Items'),
            ),
            Expanded(
              child:
                ListView(
                  children: fruitsMap.keys.map((String key) {
                    return CheckboxListTile(
                      value: fruitsMap[key],
                      title: Text(key),
                      onChanged: (value){
                        setState(() {
                          fruitsMap[key] = value!;
                        });
                      },
                    );
                  }).toList(),
                ),
            )
          ],
        ),
      )
    );
  }
}