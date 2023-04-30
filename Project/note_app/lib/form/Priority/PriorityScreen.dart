
import 'package:flutter/material.dart';
import 'package:note_app/db/PriorityDatabase.dart';
import 'package:note_app/form/Priority/PriorityCard.dart';
import 'package:note_app/model/Priority.dart';
import 'package:note_app/model/User.dart';

import '../../ultilities/Constant.dart';

// ignore: must_be_immutable
class PriorityScreen extends StatelessWidget {

  User user;

  PriorityScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _MyPriorityScreen(user: user,));
  }
}

// ignore: must_be_immutable
class _MyPriorityScreen extends StatefulWidget {

  User user;

  _MyPriorityScreen({Key? key, required this.user}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<_MyPriorityScreen> createState() => _MyPriorityScreenState(user: user);

}

class _MyPriorityScreenState extends State<_MyPriorityScreen> {

  User user;

  _MyPriorityScreenState({ required this.user});

  List<Map<String, dynamic>> _priorities = [];

  bool _isLoading = true;

  Future<void> _refreshPriorities() async {
    final List<Map<String, dynamic>> data = await PrioritySQLHelper.getAllPriorities(user.id!);

    setState(() {
      _priorities = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshPriorities();
  }

  final TextEditingController _textNameController = TextEditingController();

  void _showForm(int? id) async {

    if(id != null) {
      final existingJournal =
      _priorities.firstWhere((element) => element[Constant.KEY_PRIORITY_ID] == id);
      _textNameController.text = existingJournal[Constant.KEY_PRIORITY_NAME];
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
            bottom: MediaQuery.of(context).viewInsets.bottom + 400,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextFormField(
                controller: _textNameController,
                decoration: const InputDecoration(hintText: 'Name'),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  if( id == null) {
                    if(_textNameController.text != ""){
                      await _addItem();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Enter some text')));
                    }
                  }

                  if(id != null){
                    await _updateItem(id);
                  }

                  _textNameController.text = '';

                  if(!mounted) return;

                  Navigator.of(context).pop();
                },
                child: Text(id == null ? "Create New" : "Update"),
              )
            ],
          ),
        )
    );
  }

  Future<void> _addItem() async{
    int? id = await PrioritySQLHelper.createPriority(Priority(
        name: _textNameController.text,
        userId: user.id
    ));
    if(id != null){
      _refreshPriorities();
    } else {
      if(!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Available Priority')));
    }
  }

  Future<void> _updateItem(int id) async {
    await PrioritySQLHelper.updatePriority(Priority(
        id: id,
        name: _textNameController.text,
        userId: user.id
    ));
    _refreshPriorities();
  }

  Future<void> _deleteItem(int id) async {
    await PrioritySQLHelper.deletePriority(id);

    if(!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a priority!'),
    ));

    _refreshPriorities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
          itemCount: _priorities.length,
          itemBuilder: (context, index) => Card(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PriorityCard(priority: Priority.fromMap(_priorities[index])),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () => _showForm(_priorities[index][Constant.KEY_PRIORITY_ID]),
                        icon: const Icon(Icons.edit, color: Colors.orange,)
                    ),
                    IconButton(
                        onPressed: () => _deleteItem(_priorities[index][Constant.KEY_PRIORITY_ID]),
                        icon: const Icon(Icons.delete, color: Colors.red,)
                    ),
                  ],
                ),
              ],
            ),
          )
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showForm(null),
      ),
    );
  }
}