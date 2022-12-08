import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:readme_editor/screens/auth_screen.dart';
import 'package:readme_editor/screens/home.dart';
import 'package:readme_editor/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (BuildContext context, AsyncSnapshot snapshot) => MaterialApp(
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
        home: snapshot.connectionState != ConnectionState.done
            ? SplashScreen()
            : StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SplashScreen();
                  }
                  if (snapshot.hasData) {
                    return Home();
                  }
                  return AuthScreen();
                },
              ),
      ),
    );
  }
}
