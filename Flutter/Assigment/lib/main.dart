
import 'package:buoi_4_bai_1/buoi15/extraTask/product/ProductPage.dart';
import 'package:flutter/material.dart';

import 'buoi15/assignment/MyCounterApp.dart';
import 'buoi15/extraTask/weather/bloc/weather_bloc.dart';
import 'buoi15/extraTask/weather/data/weather_repository.dart';
import 'buoi15/extraTask/weather/page/weather_search_page.dart';
import 'buoi15/extraTask/weather/weather_page.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: BlocProvider(
        create: (context) => WeatherBloc(FakeWeatherRepository()),
        child: const WeatherSearchPage(),
      ),
    );
  }
}

// import 'package:buoi_4_bai_1/buoi13/extra/ListPage.dart';
// import 'package:flutter/material.dart';
// // ignore: depend_on_referenced_packages
// import 'package:firebase_core/firebase_core.dart';
//
// import 'buoi13/extra/AddPage.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'FreeCode Spot',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.indigo,
//         brightness: Brightness.dark,
//       ),
//       home: const ListPage(),
//     );
//   }
// }
