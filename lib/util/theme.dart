import 'package:flutter/material.dart';

ThemeData light = ThemeData(
    useMaterial3: true,
    textTheme: const TextTheme(
      titleMedium: TextStyle(fontWeight: FontWeight.w400),
    ),
    brightness: Brightness.light,
    primaryColor: const Color(0xFFFFFFFF),
    canvasColor: Colors.black,
    colorScheme: ColorScheme.light(
      primary: Colors.green.shade700,
      onPrimary: const Color(0xFF102000),
      onSecondary: Colors.green.shade700,
      secondary: Colors.green.shade700,
    ),
    dividerTheme: const DividerThemeData(color: Color(0xFFB2B2B2)),
    listTileTheme: const ListTileThemeData(iconColor: Color(0xFF454546)),
    appBarTheme: const AppBarTheme(
      surfaceTintColor: Color(0xFFFFFFFF),
      color: Color(0xFFFFFFFF),
    ),
    scaffoldBackgroundColor: const Color(0xFFFFFFFF),
    cardTheme: const CardTheme(
      surfaceTintColor: Color(0xFFF2F6F0),
      color: Color(0xFFF2F6F0), //0xFFFAFAFC
    ),
    dialogTheme: const DialogTheme(
      surfaceTintColor: Color(0xFFFFFFFF),
      backgroundColor: Color(0xFFFFFFFF),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.green.shade700,
    ),
    inputDecorationTheme: InputDecorationTheme(
        focusColor: Colors.green.shade700,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.green.shade700,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        )),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedIconTheme: IconThemeData(
        color: Colors.green.shade700,
      ),
      selectedLabelStyle: TextStyle(
        color: Colors.green.shade700,
      ),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: const Color(0xFFE2E4E3),
    ),
    navigationBarTheme: NavigationBarThemeData(
        surfaceTintColor: const Color(0xFFFFFFFF),
        backgroundColor: const Color(0xFFFFFFFF),
        indicatorColor: Colors.green.shade700,
        iconTheme: MaterialStateProperty.all(const IconThemeData(
          color: Color(0xFF050505),
        )),
        labelTextStyle: MaterialStateProperty.all(const TextStyle(
            color: Color(0xFF050505), fontWeight: FontWeight.w500))),
    bottomSheetTheme:
    const BottomSheetThemeData(
        surfaceTintColor:  const Color(0xFFFFFFFF),
        modalBackgroundColor: Color(0xFFFFFFFF)));

ThemeData dark = ThemeData(
    useMaterial3: true,
    textTheme: const TextTheme(
      titleMedium: TextStyle(fontWeight: FontWeight.w400),
    ),
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF1B1C1B),
    scaffoldBackgroundColor: const Color(0xFF1B1C1B),
    canvasColor: Colors.black,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF79DD78),
      onPrimary: Color(0xFF024308),
      onSecondary: Color(0xFF79DD78),
      secondary: Color(0xFF79DD78),
    ),
    appBarTheme: const AppBarTheme(
      surfaceTintColor: Color(0xFF1B1C1B),
      color: Color(0xFF1B1C1B),
    ),
    listTileTheme: const ListTileThemeData(iconColor: Color(0xFFE2E2E9)),
    cardTheme: const CardTheme(
      surfaceTintColor: Color(0xFF272927),
      color: Color(0xFF272927),
    ),
    dialogTheme: const DialogTheme(
      surfaceTintColor: Color(0xFF303032),
      backgroundColor: Color(0xFF303032),
    ),

    inputDecorationTheme: InputDecorationTheme(
        focusColor: const Color(0xFF79DD78),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF79DD78),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey[800]!,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey[800]!,
          ),
        )),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedIconTheme: IconThemeData(color: Color(0xFF79DD78)),
      selectedLabelStyle: TextStyle(color: Color(0xFF79DD78)),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: Color(0xFF272927),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF80DA8A), //353537
    ),
    dividerTheme: const DividerThemeData(color: Color(0xFF424342)),
    navigationBarTheme: NavigationBarThemeData(
        surfaceTintColor: const Color(0xFF1B1C1B),
        backgroundColor: const Color(0xFF1B1C1B),
        indicatorColor: const Color(0xff375233),
        iconTheme: MaterialStateProperty.all(const IconThemeData(
          color: Color(0xffe3e3e2),
        )),
        labelTextStyle: MaterialStateProperty.all(const TextStyle(
            color: Color(0xffe3e3e2), fontWeight: FontWeight.w500))),
    bottomSheetTheme:
    const BottomSheetThemeData(
        surfaceTintColor: const Color(0xFF1B1C1B),
        modalBackgroundColor: Color(0xFF1B1C1B))
);
