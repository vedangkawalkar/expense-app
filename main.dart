import 'package:flutter/material.dart';
import 'package:expenseapp/widgets/expenses.dart';
// import 'package:flutter/services.dart';

var kcolorscheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 255, 171, 171));

var kdarkcolorscheme =ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 255, 171, 171));
void main() {
// WidgetsFlutterBinding.ensureInitialized();
// SystemChrome.setPreferredOrientations([
//   DeviceOrientation.portraitUp,
// ]).then((fn) {
  runApp(MaterialApp(
    darkTheme:ThemeData.dark().copyWith(
      colorScheme: kdarkcolorscheme,
       cardTheme: const CardTheme().copyWith(
            color: kdarkcolorscheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kdarkcolorscheme.primaryContainer,
              foregroundColor: kdarkcolorscheme.onPrimaryContainer
            ),
          ),
    ),
      theme: ThemeData().copyWith(
          //scaffoldBackgroundColor: const Color.fromARGB(255, 170, 201, 255)
          colorScheme: kcolorscheme,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kcolorscheme.onPrimaryContainer,
            foregroundColor: kcolorscheme.primaryContainer,
          ),
          cardTheme: const CardTheme().copyWith(
            color: kcolorscheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kcolorscheme.primaryContainer,
            ),
          ),
          textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kcolorscheme.onSecondaryContainer,
                  fontSize: 16,
                ),
              )),
              themeMode: ThemeMode.system,
      home: const Expenses()));
}
