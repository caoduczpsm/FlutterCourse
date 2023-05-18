// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/weather.dart';
import '../data/weather_repository.dart';
part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc(this.weatherRepository) : super(WeatherInitial()) {
    // Register event handlers
    on<GetWeather>((event, emit) async {
      // Handle GetWeather event
      try {
        emit(WeatherLoading());
        final weather = await weatherRepository.fetchWeather(event.cityName);
        emit(WeatherLoaded(weather));
      } catch (e) {
        emit(WeatherError("Something went wrong"));
      }
    });
  }
}
