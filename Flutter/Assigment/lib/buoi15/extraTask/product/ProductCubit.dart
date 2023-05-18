// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<int> {
  ProductCubit() : super(1);

  void increase() => emit(state + 1);
  void decrease() => state > 0 ? emit(state - 1) : state;
}