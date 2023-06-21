import 'package:flutter/material.dart';

ThemeData themeData(BuildContext context) {
  return ThemeData(
      // platform: TargetPlatform.linux,
      textTheme: TextTheme(),
      useMaterial3: true,
      cardColor: Colors.white,
      cardTheme: CardTheme(surfaceTintColor: Colors.white),
      scaffoldBackgroundColor: Color(0xFEEEEEE),

      // fontFamily: GoogleFonts.questrial().fontFamily,
      // fontFamily: GoogleFonts.rubik().fontFamily,
      // fontFamily: GoogleFonts.roboto().fontFamily,
      primaryColor: const Color(0xFF2f3878),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Color(0xFF2f3878),
      ),
      drawerTheme: DrawerThemeData(),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF2f3878),
      ),
      inputDecorationTheme: InputDecorationTheme(
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0),
            borderRadius: BorderRadius.circular(15.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0),
            borderRadius: BorderRadius.circular(15.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
            borderRadius: BorderRadius.circular(15.0),
          ),
          border: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
            borderRadius: BorderRadius.circular(15.0),
          ),
          focusColor: const Color(0xFF004b85),
          fillColor: Colors.white,
          labelStyle: const TextStyle(
            color: Colors.grey,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(
              width: 2,
              color: Color.fromARGB(255, 198, 198, 198),
            ),
          ),
          floatingLabelStyle: const TextStyle(color: Color(0xFF004b85))),
      appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: Colors.white)),
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(
              secondary: const Color(0xFF2f3878),
              tertiary: const Color(0xFFF4F4F4))
          .copyWith(background: const Color(0xFF2f3878)));
}
