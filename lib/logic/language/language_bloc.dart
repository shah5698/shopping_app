import 'package:flutter/material.dart' show Locale;

import 'package:flutter_bloc/flutter_bloc.dart';

import 'language_event.dart';
import 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(const LanguageInitialState(locale: Locale("en", "US"))) {
    on<LoadLanguageEvent>((event, emit) async {
      emit(LanguageChangedState(locale: event.locale));
    });
  }
}