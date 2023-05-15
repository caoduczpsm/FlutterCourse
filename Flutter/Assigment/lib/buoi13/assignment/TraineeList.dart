import 'dart:convert';

import 'package:buoi_4_bai_1/buoi13/assignment/Trainee.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class TraineeList extends StatelessWidget {
  const TraineeList({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: _HomePage(),
    );
  }
}

class _HomePage extends StatefulWidget {
  const _HomePage();

  @override
  State<_HomePage> createState() => _HomePageState();
}

enum Gender { male, female }

class _HomePageState extends State<_HomePage> {
  late Future<List<Trainee>> futureTrainees;

  @override
  void initState() {
    super.initState();
    futureTrainees = fetchTrainees();
  }

  static const titleStyle = TextStyle(fontSize: 18);

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  Gender _gender = Gender.male;

  void _showForm(Trainee? trainee) async {
    if (trainee != null) {
      nameController.text = trainee.name!;
      emailController.text = trainee.email!;
      phoneController.text = trainee.phone!;
      if (trainee.gender?.toLowerCase() == Gender.male.name) {
        _gender = Gender.male;
      } else {
        _gender = Gender.female;
      }
    } else {
      nameController.text = "";
      emailController.text = "";
      phoneController.text = "";
      _gender = Gender.male;
    }

    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
              padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                bottom: MediaQuery.of(context).viewInsets.bottom + 120,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(hintText: 'Name'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(hintText: 'Email'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: phoneController,
                    decoration: const InputDecoration(hintText: 'Phone'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                    return Row(
                      children: <Widget>[
                        Expanded(
                          child: RadioListTile(
                            title: const Text('Male'),
                            value: Gender.male,
                            groupValue: _gender,
                            onChanged: (Gender? value) {
                              setState(() {
                                _gender = value!;
                              });
                            },
                          ),
                        ),
                        Expanded(
                            child: RadioListTile(
                          title: const Text('Female'),
                          value: Gender.female,
                          groupValue: _gender,
                          onChanged: (Gender? value) {
                            setState(() {
                              _gender = value!;
                            });
                          },
                        ))
                      ],
                    );
                  }),
                  Center(
                    child: ElevatedButton(
                        onPressed: () {
                          trainee == null
                              ? createTrainee()
                              : updateTrainee(trainee);
                          Navigator.of(context).pop();
                        },
                        child: Text(trainee == null
                            ? "Create Trainee"
                            : "Update Trainee")
                    ),
                  )
                ],
              ),
            ));
  }

  List<Trainee> parseTrainees(String response) {
    final parsed = jsonDecode(response).cast<Map<String, dynamic>>();
    return parsed.map<Trainee>((json) => Trainee.fromJson(json)).toList();
  }

  Future<List<Trainee>> fetchTrainees() async {
    const url =
        "https://645efc1d9d35038e2d1b1486.mockapi.io/trainee-app/trainees";
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return parseTrainees(response.body);
    } else {
      throw Exception("Failed to load Todo");
    }
  }

  Future<void> _refreshTrainees() async {
    final result = fetchTrainees();
    setState(() {
      futureTrainees = result;
    });
  }

  Future<void> deleteById(String id) async {
    final url =
        "https://645efc1d9d35038e2d1b1486.mockapi.io/trainee-app/trainees/${id}";
    final uri = Uri.parse(url);
    final response = await http.delete(uri);

    if (response.statusCode == 200) {
      _refreshTrainees();
      showMessage("Deletion Success");
    } else {
      showMessage("Deletion Failed");
    }
  }

  Future<void> updateTrainee(Trainee trainee) async {
    final id = trainee.id!;
    final url =
        "https://645efc1d9d35038e2d1b1486.mockapi.io/trainee-app/trainees/$id";
    final uri = Uri.parse(url);
    final body = {
      "name": nameController.text,
      "email": emailController.text,
      "phone": phoneController.text,
      "gender": _gender.name
    };
    final response = await http.put(uri, body: body);

    if (response.statusCode == 200 && mounted) {
      _refreshTrainees();
      showMessage("Edition Success");
    } else {
      showMessage("Edition Failed");
    }
  }

  Future<void> createTrainee() async {
    final name = nameController.text;
    final phone = phoneController.text;
    final email = emailController.text;
    final body = {
      "name": name,
      "email": email,
      "phone": phone,
      "gender": _gender.name
    };

    const url = "https://645efc1d9d35038e2d1b1486.mockapi.io/trainee-app/trainees";
    final uri = Uri.parse(url);
    final response = await http.post(uri, body: body);

    if (response.statusCode == 201 && mounted) {
      nameController.text = "";
      phoneController.text = "";
      emailController.text = "";
      _refreshTrainees();
      showMessage("Creation Success");
    } else {
      showMessage("Creation Failed");
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trainee List"),
      ),
      body: Center(
        child: RefreshIndicator(
          onRefresh: _refreshTrainees,
          child: FutureBuilder(
            future: futureTrainees,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("Retrieve Failed ${snapshot.error}");
              } else if (snapshot.hasData) {
                final List<Trainee> trainees = snapshot.data!;
                return ListView.builder(
                  itemCount: trainees.length,
                  itemBuilder: (context, index) => Card(
                    child: (ListTile(
                      leading: Text(
                        "${trainees[index].phone}",
                        style: titleStyle,
                      ),
                      title: Text(
                        "${trainees[index].name}",
                        style: titleStyle,
                      ),
                      subtitle: Text(
                        "${trainees[index].email}",
                        maxLines: 1,
                      ),
                      trailing: SizedBox(
                        width: 40,
                        child: PopupMenuButton(
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                            const PopupMenuItem(
                                value: 'edit', child: Text('Edit')),
                            const PopupMenuItem(
                                value: 'Delete', child: Text('Delete')),
                          ],
                          onSelected: (String result) {
                            Trainee trainee = Trainee(
                                phone: trainees[index].phone,
                                name: trainees[index].name,
                                email: trainees[index].email,
                                id: trainees[index].id,
                                gender: trainees[index].gender);
                            if (result == "edit") {
                              _showForm(trainee);
                            } else {
                              deleteById("${trainees[index].id}");
                            }
                          },
                        ),
                      ),
                    )),
                  ),
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(null),
        child: const Icon(Icons.add),
      ),
    );
  }
}
