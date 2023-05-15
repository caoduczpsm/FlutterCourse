
import 'package:buoi_4_bai_1/buoi13/assignment/Trainee.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class AddTraineePage extends StatefulWidget {
  final Trainee? trainee;

  const AddTraineePage({super.key, this.trainee});

  @override
  State<AddTraineePage> createState() => _AddTraineePageState();
}

class _AddTraineePageState extends State<AddTraineePage>{
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isUpdate = false;

  @override
  void initState() {
    super.initState();

    if(widget.trainee != null){
      titleController.text = widget.trainee!.name!;
      descriptionController.text = widget.trainee!.email!;
      isUpdate = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdate ? "Update Trainee" : "Add Trainee"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          TextFormField(
            controller: titleController,
            decoration: const InputDecoration(hintText: "Name"),
          ),
          TextFormField(
            controller: descriptionController,
            decoration: const InputDecoration(hintText: "Email"),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: isUpdate? update : submit,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(isUpdate? "Update" : "Submit"),
              )
          )
        ],
      ),
    );
  }

  Future<void> submit() async {
    final title = titleController.text;
    final description = descriptionController.text;
    final body = {"name": title, "email": description};

    const url = "https://60db1a79801dcb0017290e61.mockapi.io/todos";
    final uri = Uri.parse(url);
    final response = await http.post(uri, body: body);

    if(response.statusCode == 201 && mounted){
      titleController.text = "";
      descriptionController.text = "";
      showMessage("Creation Success");
    } else {
      showMessage("Creation Failed");
    }
  }

  Future<void> update() async {
    final trainee = widget.trainee;
    final id = trainee!.id!;
    final url = "https://60db1a79801dcb0017290e61.mockapi.io/todos/$id";
    final uri = Uri.parse(url);
    final body = {
      "name": titleController.text,
      "email": descriptionController.text
    };
    final response = await http.put(uri, body: body);

    if(response.statusCode == 200 && mounted){
      showMessage("Edition Success");
    } else {
      showMessage("Edition Failed");
    }
  }

  void showMessage(String message){
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}

