import 'package:flutter/material.dart';
import 'package:flutter_application_4/views/buttom.dart';
import 'package:flutter_application_4/views/doctor_details.dart';
import 'package:flutter_application_4/views/doctors_by_specialty_view.dart';
import 'package:flutter_application_4/views/globals.dart';
// import 'package:flutter_application_4/views/lab7.dart';
//import 'package:flutter_application_4/views/lab7.dart';
import 'package:flutter_application_4/views/login_view.dart';
import 'package:flutter_application_4/views/new_code/home.dart';
import 'package:flutter_application_4/theme/real_estate_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
//import 'package:flutter_application_4/views/splash_views/first_splash_view.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';
//import 'package:flutter_application_4/views/buttom.dart';
//import 'package:flutter_application_4/views/doctor_details.dart';
//import 'package:flutter_application_4/views/login_view.dart';
//import 'package:flutter_application_4/views/main_view.dart';
//import 'package:flutter_application_4/views/main_view.dart';
//import 'package:flutter_application_4/Screens/login.dart';
//import 'package:flutter_application_4/views/main_view.dart';
//import 'package:flutter_application_4/views/splash_views/first_splash_view.dart';
//import 'package:flutter_application_4/views/login_view.dart';
//import 'package:flutter_application_4/views/main_view.dart';
// import 'package:flutter_application_4/views/login_view.dart';
// import 'package:flutter_application_4/views/signup_view.dart';
import 'package:flutter_application_4/views/splash_views/first_splash_view.dart';

void main() => runApp(AppoinmentApp());

class AppoinmentApp extends StatelessWidget {
  const AppoinmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: RealEstateTheme.themeData,

      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'),
      supportedLocales: const [Locale('ar')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (context, child) {
        final media = MediaQuery.of(context);
        final isWide = media.size.width > 500;
        return ColoredBox(
          color: const Color(0xFFF2F4F8),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: ClipRect(
                child: MediaQuery(
                  data: isWide
                      ? media.copyWith(size: Size(500, media.size.height))
                      : media,
                  child: child!,
                ),
              ),
            ),
          ),
        );
      },
      initialRoute: '/',
      routes: {
        '/': (context) => const FirstSplashView(),
        '/login': (context) => const LoginView(),
        '/main': (context) => const BottomNavBar(),
        '/dr_details': (context) => const DoctorDetails(),
        '/dr_speciality': (context) => const DoctorsBySpecialtyView(),
        RealEstateHomeView.routeName: (context) => const RealEstateHomeView(),
      },
    );
  }
}
