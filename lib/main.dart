import 'package:flutter/material.dart';
import 'package:mymoney_app/src/home.dart';
import 'src/login.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColorDark: Color(0xff1b262c),
        primaryColor: Color(0xff0f4c75),
        accentColor: Color(0xff0f4c81),
      ),
      initialRoute: '/login', // user_logged ? '/' : '/login',
      routes: {
        '/': (context) => HomePage(),
        '/login': (context) => LoginPage(),
      },
    );
  }
}
