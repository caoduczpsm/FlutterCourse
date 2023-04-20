import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class DetailsScreen extends StatelessWidget {

  final Set<WordPair> saved;
  final TextStyle biggerFont;

  const DetailsScreen({super.key, required this.saved, required this.biggerFont});

  @override
  Widget build(BuildContext context) {
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

    final divided = tiles.isNotEmpty
        ? ListTile.divideTiles(context: context, tiles: tiles).toList()
        : <Widget>[];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Suggestions'),
      ),
      body: ListView(children: divided),
    );
  }
}