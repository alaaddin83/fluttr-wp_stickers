import 'package:flutter/material.dart';
import 'package:whatsapp_sticker/Screens/home_page.dart';
import 'package:whatsapp_sticker/Screens/splash_screen.dart';
import 'package:whatsapp_sticker/constants.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:whatsapp_sticker/function/app_Localizations.dart';

//import 'function/app_Localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //title: kTitle,

      theme: ThemeData(
        primaryColor: kPrimaryColor2,
        //primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      supportedLocales: [
        const Locale('en'), // English, no country code

        const Locale('ar'),
      ],

      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        AppLocalization.delegate,

        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        //GlobalCupertinoLocalizations.delegate,
      ],

      //
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocaleLanguage in supportedLocales) {
          if (supportedLocaleLanguage.languageCode == locale.languageCode
              // && supportedLocaleLanguage.countryCode == locale.countryCode
              ) {
            return supportedLocaleLanguage;
          }
        }

        // If device not support with locale to get language code then default get first on from the list
        return supportedLocales.first;
      },

      // home: MyHomePage(title: kTitle),
      initialRoute: SplashScreen.id,

      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        HomePage.id: (context) => HomePage(),
      },
    );
  }
}
