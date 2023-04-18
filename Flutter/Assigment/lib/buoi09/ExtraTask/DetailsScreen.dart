import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

// Thêm dòng này
class DetailsScreen extends StatelessWidget {
  // Khai báo các biến thành viên
  final Set<WordPair> saved;
  final TextStyle biggerFont;

  // Khai báo hàm khởi tạo với 2 tham số đặt tên
  DetailsScreen({required this.saved, required this.biggerFont});

  // Phương thức build để trả về widget
  @override // Thêm dòng này
  Widget build(BuildContext context) {
    // Tạo một danh sách các ListTile chứa các wordpair trong saved
    final tiles = saved.map(
          (WordPair pair) {
        return ListTile(
          title: Text(
            pair.asPascalCase,
            style: biggerFont,
          ),
        );
      },
    );
    // Tạo một danh sách các widget chứa các ListTile và các dòng phân cách
    final divided = tiles.isNotEmpty
        ? ListTile.divideTiles(context: context, tiles: tiles).toList()
        : <Widget>[];
    // Trả về một Scaffold chứa danh sách các widget
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Suggestions'),
      ),
      body: ListView(children: divided),
    );
  }
}