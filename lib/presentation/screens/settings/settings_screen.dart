import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/app_localization.dart';

import '../../../logic/language/language_bloc.dart';
import '../../../logic/language/language_event.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String dropdownValue = 'English';

  // List of items in our dropdown menu
  var items = [
    'English',
    'German',
  ];

  @override
  Widget build(BuildContext context) {
    final languageBloc = BlocProvider.of<LanguageBloc>(context);
    return Scaffold(
        appBar: AppBar(
          title:
              Text(AppLocalization.of(context).getTranslatedValues("settings")),
        ),
        body: ListTile(
          title:
              Text(AppLocalization.of(context).getTranslatedValues("language")),
          trailing: DropdownButton(
              value: dropdownValue,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? value) {
                if (value == "English") {
                  setState(() {
                    dropdownValue = value!;
                    languageBloc
                        .add(const LoadLanguageEvent(locale: Locale("en", "")));
                  });
                } else {
                  setState(() {
                    dropdownValue = value!;
                    languageBloc.add(
                        const LoadLanguageEvent(locale: Locale("de", "GR")));
                  });
                }
              }),
        ));
  }
}
