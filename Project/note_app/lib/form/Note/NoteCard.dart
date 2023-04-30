
import 'package:flutter/material.dart';
import 'package:note_app/model/NoteDetail.dart';

// ignore: must_be_immutable
class NoteCard extends StatelessWidget {

  NoteDetail noteDetail;

  NoteCard({Key? key, required this.noteDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: _MyCategoryCard(noteDetail: noteDetail),
    );
  }
}

// ignore: must_be_immutable
class _MyCategoryCard extends StatefulWidget {

  NoteDetail noteDetail;

  _MyCategoryCard({Key? key, required this.noteDetail}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<_MyCategoryCard> createState() => _MyCategoryCardState(noteDetail: noteDetail);
}

class _MyCategoryCardState extends State<_MyCategoryCard> {

  NoteDetail noteDetail;

  _MyCategoryCardState({required this.noteDetail});

  static const textNormalStyle = TextStyle(fontSize: 20);


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
          width: 320,
          height: 210,
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
                          noteDetail.name!,
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
                                const Icon(Icons.category),
                                Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  child: Text("Category: ${noteDetail.categoryName}", style: textNormalStyle,),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: Row(
                              children: [
                                const Icon(Icons.low_priority),
                                Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  child: Text("Priority: ${noteDetail.priorityName}", style: textNormalStyle,),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: Row(
                              children: [
                                const Icon(Icons.signal_wifi_statusbar_4_bar),
                                Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  child: Text("Status: ${noteDetail.statusName}", style: textNormalStyle,),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: Row(
                              children: [
                                const Icon(Icons.next_plan),
                                Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  child: Text("Plan Date: ${noteDetail.planDate}", style: textNormalStyle,),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: Row(
                              children: [
                                const Icon(Icons.lock_clock),
                                Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  child: Text("Created at: ${noteDetail.createdDate}", style: textNormalStyle,),
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