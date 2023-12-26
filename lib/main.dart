import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ponto_tattoo/splash_page.dart';

void main() {
  runApp(MaterialApp(
    home: SplashPage(), //BottomNavigationBarMenu(),RegisterStepTwoPage
    //debugShowCheckedModeBanner: false,
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate
    ],
    supportedLocales: [
      const Locale('pt', 'BR'),
    ],
  ));
}
