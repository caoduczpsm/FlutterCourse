
import 'package:flutter/material.dart';
import 'package:note_app/db/StatusDatabase.dart';
import 'package:note_app/form/Status/StatusCard.dart';
import 'package:note_app/model/Status.dart';
import 'package:note_app/model/User.dart';

import '../../ultilities/Constant.dart';

class StatusScreen extends StatelessWidget {

  User user;

  StatusScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _MyStatusScreen(user: user,));
  }
}

// ignore: must_be_immutable
class _MyStatusScreen extends StatefulWidget {

  User user;

  _MyStatusScreen({Key? key, required this.user}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<_MyStatusScreen> createState() => _MyStatusScreenState(user: user);
}

class _MyStatusScreenState extends State<_MyStatusScreen> {

  User user;

  _MyStatusScreenState({required this.user});

  List<Map<String, dynamic>> _statuses = [];

  bool _isLoading = true;

  Future<void> _refreshStatues() async {
    final List<Map<String, dynamic>> data = await StatusSQLHelper.getAllStatuses(user.id!);

    setState(() {
      _statuses = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshStatues();
  }

  final TextEditingController _textNameController = TextEditingController();

  void _showForm(int? id) async {

    if(id != null) {
      final existingJournal =
      _statuses.firstWhere((element) => element[Constant.KEY_STATUS_ID] == id);
      _textNameController.text = existingJournal[Constant.KEY_STATUS_NAME];
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
    int? id = await StatusSQLHelper.createStatus(Status(
        name: _textNameController.text,
        userId: user.id
    ));
    if(id != null){
      _refreshStatues();
    } else {
      if(!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Available Category')));
    }
  }

  Future<void> _updateItem(int id) async {
    await StatusSQLHelper.updateStatus(Status(
        id: id,
        name: _textNameController.text,
        userId: user.id
    ));
    _refreshStatues();
  }

  Future<void> _deleteItem(int id) async {
    await StatusSQLHelper.deleteStatus(id);

    if(!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a status!'),
    ));

    _refreshStatues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
          itemCount: _statuses.length,
          itemBuilder: (context, index) => Card(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StatusCard(status: Status.fromMap(_statuses[index])),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () => _showForm(_statuses[index][Constant.KEY_PRIORITY_ID]),
                        icon: const Icon(Icons.edit, color: Colors.orange,)
                    ),
                    IconButton(
                        onPressed: () => _deleteItem(_statuses[index][Constant.KEY_PRIORITY_ID]),
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