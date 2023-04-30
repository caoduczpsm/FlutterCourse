
import 'package:flutter/material.dart';
import 'package:note_app/model/Categories.dart';

// ignore: must_be_immutable
class CategoryCard extends StatelessWidget {

  Categories category;

  CategoryCard({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: _MyCategoryCard(category: category),
    );
  }
}

// ignore: must_be_immutable
class _MyCategoryCard extends StatefulWidget {

  Categories category;

  _MyCategoryCard({Key? key, required this.category}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<_MyCategoryCard> createState() => _MyCategoryCardState(category: category);
}

class _MyCategoryCardState extends State<_MyCategoryCard> {

  Categories category;

  _MyCategoryCardState({required this.category});

  static const textNormalStyle = TextStyle(fontSize: 20);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
          width: 320,
          height: 100,
          margin: const EdgeInsets.only(left: 5, right: 5),
          child: Center(
            child: Card(
              elevation: 5,
              shadowColor: Colors.grey,
              shape: const RoundedRectangleBorder(borderRadius:
              BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          category.name!,
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                        )
                      ],
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: Row(
                              children: [
                                const Icon(Icons.lock_clock),
                                Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  child: Text("Created at: ${category.createdDate}", style: textNormalStyle,),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
}