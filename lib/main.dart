import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:readme_editor/screens/auth_screen.dart';
import 'package:readme_editor/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReadMe Editor',
      theme: ThemeData(
          primaryColor: Colors.purple[900],
          backgroundColor: Colors.purple[900],
          accentColor: Colors.orange[400],
          accentColorBrightness: Brightness.dark,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.purple[900]),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              textStyle: MaterialStateProperty.all(
                TextStyle(color: Colors.purple[900]),
              ),
            ),
          )),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Home();
          }
          return AuthScreen();
        },
      ),
    );
  }
}
