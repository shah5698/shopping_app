import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/logic/products_list/products_list_bloc.dart';
import 'package:shopping_app/presentation/router/app_router.dart';
import 'package:shopping_app/presentation/screens/cart_screen/cart_screen.dart';
import 'package:shopping_app/presentation/screens/home_screen/home_screen.dart';
import 'package:shopping_app/presentation/screens/settings/settings_screen.dart';
import '/logic/language/language_bloc.dart';
import '/logic/language/language_state.dart';
import '/logic/network/network_bloc.dart';
import '/logic/network/network_state.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_localization.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => NetworkBloc()),
        BlocProvider(create: (BuildContext context) => LanguageBloc()),
        BlocProvider(create: (BuildContext context) => ProductsListBloc()),
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, languageState) {
          return MaterialApp(
              locale: languageState.locale,
              localizationsDelegates: const [
                AppLocalization.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale("en", ""),
                Locale("de", ""),
              ],
              onGenerateRoute: AppRouter.onGenerateRoute,
              home: const ShoppingApp());
        },
      ),
    ),
  );
}

class ShoppingApp extends StatefulWidget {
  const ShoppingApp({
    Key? key,
  }) : super(key: key);

  @override
  State<ShoppingApp> createState() => _ShoppingAppState();
}

class _ShoppingAppState extends State<ShoppingApp> {
  int currentIndex = 0;
  final screens = [
    const HomeScreen(),
    const CartScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NetworkBloc, NetworkState>(
      listener: (context, networkState) {
        if (networkState is NetworkDisconnectedState) {
          AwesomeDialog(
            context: context,
            isDense: false,
            animType: AnimType.topSlide,
            dialogType: DialogType.error,
            body: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text("Internet lost"),
            ),
            btnOkOnPress: () {},
          ).show();
        }
      },
      builder: (context, networkState) {
        if (networkState is NetworkConnectedState) {
          return Scaffold(
            body: IndexedStack(
              index: currentIndex,
              children: screens,
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                    icon: const Icon(Icons.home),
                    label:
                        AppLocalization.of(context).getTranslatedValues("home"),
                    backgroundColor: Colors.blue),
                BottomNavigationBarItem(
                    icon: const Icon(Icons.shopping_cart),
                    label:
                        AppLocalization.of(context).getTranslatedValues("cart"),
                    backgroundColor: Colors.blue),
                BottomNavigationBarItem(
                    icon: const Icon(Icons.settings),
                    label: AppLocalization.of(context)
                        .getTranslatedValues("settings"),
                    backgroundColor: Colors.blue),
              ],
            ),
          );
        } else if (networkState is NetworkDisconnectedState) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Weather App"),
            ),
            body: Center(
              child: Text(
                AppLocalization.of(context)
                    .getTranslatedValues("internetConnectionLost!"),
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
