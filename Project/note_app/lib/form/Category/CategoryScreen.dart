import 'package:flutter/material.dart';
import 'package:note_app/db/CategoryDatabase.dart';
import 'package:note_app/form/Category/CategoryCard.dart';
import 'package:note_app/model/Categories.dart';
import 'package:note_app/model/User.dart';
import 'package:note_app/ultilities/Constant.dart';

// ignore: must_be_immutable
class CategoryScreen extends StatelessWidget {

  User user;

  CategoryScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _CategoryScreen(user: user));
  }
}

// ignore: must_be_immutable
class _CategoryScreen extends StatefulWidget{

  User user;

  _CategoryScreen({Key? key, required this.user}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<_CategoryScreen> createState() => _CategoryScreenState(user: user);
}

class _CategoryScreenState extends State<_CategoryScreen> {

  User user;

  _CategoryScreenState({required this.user});

  List<Map<String, dynamic>> _categories = [];
  bool _isLoading = true;

  Future<void> _refreshCategories() async {
    final List<Map<String, dynamic>> data = await CategorySQLHelper.getAllCategories(user.id!);
    setState(() {
      _categories = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshCategories();
  }

  final TextEditingController _textNameController = TextEditingController();

  void _showForm(int? id) async {

    if(id != null) {
      final existingJournal =
      _categories.firstWhere((element) => element[Constant.KEY_CATEGORY_ID] == id);
      _textNameController.text = existingJournal[Constant.KEY_CATEGORY_NAME];
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
    int? id = await CategorySQLHelper.createCategory(Categories(
        name: _textNameController.text,
        userId: user.id
    ));
    if(id != null){
      _refreshCategories();
    } else {
      if(!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Available Category')));
    }
  }

  Future<void> _updateItem(int id) async {
    await CategorySQLHelper.updateCategory(Categories(
        id: id,
        name: _textNameController.text,
        userId: user.id,
      createdDate: "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day} "
          "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}"
    ));
    _refreshCategories();
  }

  Future<void> _deleteItem(int id) async {
    await CategorySQLHelper.deleteCategory(id);

    if(!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a priority!'),
    ));
    _refreshCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
          itemCount: _categories.length,
          itemBuilder: (context, index) => Card(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CategoryCard(category: Categories.fromMap(_categories[index])),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () => _showForm(_categories[index][Constant.KEY_CATEGORY_ID]),
                        icon: const Icon(Icons.edit, color: Colors.orange,)
                    ),
                    IconButton(
                        onPressed: () => _deleteItem(_categories[index][Constant.KEY_CATEGORY_ID]),
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