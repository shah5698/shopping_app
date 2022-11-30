import 'package:flutter/material.dart' show immutable, Locale;

@immutable
abstract class LanguageEvent {
  const LanguageEvent();
}

class LoadLanguageEvent extends LanguageEvent {
  final Locale locale;
  const LoadLanguageEvent({required this.locale});
}
