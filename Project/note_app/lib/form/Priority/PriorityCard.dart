
import 'package:flutter/material.dart';
import 'package:note_app/model/Priority.dart';
// ignore: must_be_immutable
class PriorityCard extends StatelessWidget {

  Priority priority;

  PriorityCard({Key? key, required this.priority}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: _MyPriorityCard(priority: priority),
    );
  }
}

// ignore: must_be_immutable
class _MyPriorityCard extends StatefulWidget {

  Priority priority;

  _MyPriorityCard({Key? key, required this.priority}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<_MyPriorityCard> createState() => _MyPriorityCardState(priority: priority);
}

class _MyPriorityCardState extends State<_MyPriorityCard> {

   Priority priority;

  _MyPriorityCardState({required this.priority});

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
                          priority.name!,
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
                                  child: Text("Created at: ${priority.createdDate}", style: textNormalStyle,),
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