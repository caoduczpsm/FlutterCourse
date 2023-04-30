import 'package:buoi_4_bai_1/buoi10/Assignment/sql_helper.dart';
import 'package:flutter/material.dart';

import 'item.dart';

class ItemsScreen extends StatelessWidget {
  const ItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: _HomePage(),
    );
  }
}

class _HomePage extends StatefulWidget{
  const _HomePage({Key? key}) : super(key: key);

  @override
  State<_HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  List<Map<String, dynamic>> _journals = [];

  bool _isLoading = true;

  Future<void> _refreshJournals() async {
    final List<Map<String, dynamic>> data = await SQLHelper.getItems();

    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshJournals();
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _showForm(int? id) async {

    if(id != null) {
      final existingJournal =
          _journals.firstWhere((element) => element['id'] == id);
      _titleController.text = existingJournal['title'];
      _descriptionController.text = existingJournal['description'];
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
                controller: _titleController,
                decoration: const InputDecoration(hintText: 'Title'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(hintText: 'Description'),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if( id == null) {
                      await _addItem();
                    }

                    if(id != null){
                      await _updateItem(id);
                    }

                    _titleController.text = '';
                    _descriptionController.text = '';

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
    await SQLHelper.createItem(Item(
      title: _titleController.text,
      description: _descriptionController.text
    ));
    _refreshJournals();
  }

  Future<void> _updateItem(int id) async {
    await SQLHelper.updateItem(Item(
      id: id,
      title: _titleController.text,
      description: _descriptionController.text
    ));
    _refreshJournals();
  }

  Future<void> _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);

    if(!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a journal!'),
    ));

    _refreshJournals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Persist data with SQLite'),
      ),
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
      : ListView.builder(
        itemCount: _journals.length,
          itemBuilder: (context, index) => Card(
            color: Colors.orange[200],
            margin: const EdgeInsets.all(15),
            child: ListTile(
              title: Text(_journals[index]['title']),
              subtitle: Text(_journals[index]['description']),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () => _showForm(_journals[index]['id']),
                        icon: const Icon(Icons.edit)
                    ),
                    IconButton(
                        onPressed: () => _deleteItem(_journals[index]['id']),
                        icon: const Icon(Icons.delete)
                    ),
                  ],
                ),
              ),
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