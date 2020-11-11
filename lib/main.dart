import 'package:flutter/material.dart';
import 'package:mymoney_app/pages/login_signup.dart';
import 'package:mymoney_app/pages/shell.dart';
import 'package:mymoney_app/pages/splash_screen.dart';
import 'package:mymoney_app/pages/login.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColorDark: Color(0xff072028),
        primaryColor: Color(0xff0f4c75),
        accentColor: Color(0xff0f4c81),
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Color(0xff072028),
              displayColor: Color(0xff072028),
            ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => ShellPage(),
        '/login': (context) => LoginPage(),
        '/login_signup': (context) => LoginSignUpPage(),
      },
    );
  }
}
