import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:readme_editor/provider/shield.dart';
import 'package:readme_editor/screens/start_screen.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Shields(),
      child: MaterialApp(
        title: 'ReadMe Shield Editor',
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
          ),
        ),
        home: StartScreen(),
      ),
    );
  }
}
