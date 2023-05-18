import 'package:buoi_4_bai_1/buoi15/extraTask/weather/cubit/weather_cubit.dart';
import 'package:buoi_4_bai_1/buoi15/extraTask/weather/data/weather_repository.dart';
import 'package:buoi_4_bai_1/buoi15/extraTask/weather/page/weather_search_page.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: BlocProvider(
        create: (context) => WeatherCubit(FakeWeatherRepository()),
        child: const WeatherSearchPage(),
      ),
    );
  }
}