import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmortyflutter/common/locale/locale_event.dart';

class LocaleBloc extends Bloc<LocaleEvent, Locale> {
  LocaleBloc(this._supported, {required Locale system})
    : super(
        _supported.firstWhere(
          (locale) => locale.languageCode == system.languageCode,
          orElse: () => _supported.first,
        ),
      ) {
    on<LocaleToggled>(_onToggled);
  }

  final List<Locale> _supported;

  void _onToggled(LocaleToggled event, Emitter<Locale> emit) {
    final index = _supported.indexWhere(
      (locale) => locale.languageCode == state.languageCode,
    );
    emit(_supported[(index + 1) % _supported.length]);
  }
}
