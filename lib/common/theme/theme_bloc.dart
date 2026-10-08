import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmortyflutter/common/theme/theme_event.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeMode> {
  ThemeBloc() : super(ThemeMode.light) {
    on<ThemeToggled>(
      (event, emit) =>
          emit(state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light),
    );
  }
}
