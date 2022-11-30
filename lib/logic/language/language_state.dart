import 'package:flutter/material.dart' show immutable, Locale;

import 'package:equatable/equatable.dart';

@immutable
abstract class LanguageState extends Equatable {
  final Locale locale;
  const LanguageState({required this.locale});

  @override
  List<Object?> get props => [locale];
}

class LanguageInitialState extends LanguageState {
  const LanguageInitialState({required Locale locale}) : super(locale: locale);
}

class LanguageChangedState extends LanguageState {
  const LanguageChangedState({required Locale locale}) : super(locale: locale);
}
