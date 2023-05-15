
import 'package:flutter/material.dart';
import '../../buoi11/assignment/todo.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class AddTodoPage extends StatefulWidget {
  final Todo? todo;
  
  const AddTodoPage({super.key, this.todo});
  
  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage>{
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isUpdate = false;
  
  @override
  void initState() {
    super.initState();
    
    if(widget.todo != null){
      titleController.text = widget.todo!.title!;
      descriptionController.text = widget.todo!.description!;
      isUpdate = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdate ? "Update Todo" : "Add Todo"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          TextFormField(
            controller: titleController,
            decoration: const InputDecoration(hintText: "Title"),
          ),
          TextFormField(
            controller: descriptionController,
            decoration: const InputDecoration(hintText: "Description"),
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
    final body = {"title": title, "description": description};

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
    final todo = widget.todo;
    final id = todo!.id!;
    final url = "https://60db1a79801dcb0017290e61.mockapi.io/todos/$id";
    final uri = Uri.parse(url);
    final body = {
      "title": titleController.text,
      "description": descriptionController.text
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

