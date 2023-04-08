import 'package:buoi_4_bai_1/buoi04/pavlovaRecipe.dart';
import 'package:buoi_4_bai_1/buoi05/extraTasks.dart';
import 'package:buoi_4_bai_1/buoi05/startupNamer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ExtraTasks());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//
//   @override
//   Widget build(BuildContext context){
//     return MaterialApp(
//       title: "Flutter layout demo",
//       home: buildHomePage('Strawberry Pavlova Recipe'),
//     );
//   }
//
//   Widget buildHomePage(String title){
//     const titleText = Padding(
//       padding: EdgeInsets.only(bottom: 10),
//       child: Text(
//         'Strawberry Pavlova',
//         style: TextStyle(
//           fontWeight: FontWeight.w800,
//           letterSpacing: 0.5,
//           fontSize: 25,
//         ),
//       ),
//     );
//
//     const subTitle = Text(
//       'Pavlova is a meringue-based dessert named after the Russian ballerina '
//           'Anna Pavlova. Pavlova features a crisp crust and soft, light inside, '
//           'topped with fruit and whipped cream.',
//       textAlign: TextAlign.center,
//       style: TextStyle(
//         fontFamily: 'Georgia',
//         fontSize: 20,
//       ),
//     );
//
//     var stars = Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Icon(Icons.star, color: Colors.green[500]),
//         Icon(Icons.star, color: Colors.green[500]),
//         Icon(Icons.star, color: Colors.green[500]),
//         const Icon(Icons.star, color: Colors.black),
//         const Icon(Icons.star, color: Colors.black)
//       ],
//     );
//
//     final ratings = Container(
//       padding: const EdgeInsets.all(20),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           stars,
//           const Text(
//             '170 Reviews',
//             style: TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.w800,
//               fontFamily: 'Roboto',
//               letterSpacing: 0.5,
//               fontSize: 20,
//             ),
//           )
//         ],
//       ),
//     );
//
//     const descTextStyle = TextStyle(
//       color: Colors.black,
//       fontWeight: FontWeight.w800,
//       fontFamily: 'Roboto',
//       letterSpacing: 0.5,
//       fontSize: 18,
//       height: 2,
//     );
//
//     final iconList = DefaultTextStyle.merge(
//         style: descTextStyle,
//         child: Container(
//           padding: const EdgeInsets.all(20),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Column(
//                 children: [
//                   Icon(Icons.kitchen, color: Colors.green[500]),
//                   const Text('PREP:'),
//                   const Text('25 min'),
//                 ],
//               ),
//               Column(
//                 children: [
//                   Icon(Icons.timer, color: Colors.green[500]),
//                   const Text('COOK:'),
//                   const Text('1 hr'),
//                 ],
//               ),
//               Column(
//                 children: [
//                   Icon(Icons.restaurant, color: Colors.green[500]),
//                   const Text('FEEDS:'),
//                   const Text('4 - 6'),
//                 ],
//               )
//             ],
//           ),
//         )
//     );
//
//     final mainImage = Image.asset(
//       'images/pavlova.jpeg',
//     );
//
//     final mainColumn = Container(
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         children: [
//           titleText,
//           subTitle,
//           ratings,
//           iconList,
//           Expanded(child: mainImage),
//         ],
//       ),
//     );
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//       ),
//       body: Container(
//         margin: const EdgeInsets.fromLTRB(0, 10, 0, 30),
//         height: 600,
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               child: SizedBox(
//                 width: 440,
//                 child: mainColumn,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
