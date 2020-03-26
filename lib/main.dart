import 'package:flutter/material.dart';
import 'package:mymoney_app/src/shell.dart';
import 'package:mymoney_app/src/splash_screen.dart';
import 'package:mymoney_app/src/login.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColorDark: Color(0xff1b262c),
        primaryColor: Color(0xff0f4c75),
        accentColor: Color(0xff0f4c81),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => ShellPage(),
        '/login': (context) => LoginPage(),
      },
    );
  }
}
