import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import "package:census_app/ui/screens/walkScreen.dart";
import 'package:census_app/ui/screens/rootScreen.dart';
import 'package:census_app/ui/screens/signInScreen.dart';
import 'package:census_app/ui/screens/signUpScreen.dart';
import 'package:census_app/ui/screens/mainScreen.dart';
import 'package:census_app/ui/screens/addCitizenScreen.dart';
import 'package:census_app/ui/screens/personScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((prefs) {
    runApp(MyApp(prefs: prefs));
  });
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  MyApp({this.prefs});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {



    return MaterialApp(
      title: 'Ghana Statistical Service',
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/walkthrough': (BuildContext context) => new WalkThroughScreen(),
        '/root': (BuildContext context) => new RootScreen(),
        '/signin': (BuildContext context) => new SignInScreen(),
        '/signup': (BuildContext context) => new SignUpScreen(),
        '/main': (BuildContext context) => new MainScreen(prefs: prefs),
        '/addcitizen': (BuildContext context) => new AddCitizen(title: "Add New Citizen",),
//        '/person': (BuildContext context) => new PersonScreen(title: "Add New Citizen",),
      },
      theme: ThemeData(
        primaryColor: Colors.white,
        primarySwatch: Colors.lightBlue,
      ),
      home: _handleCurrentScreen(),
    );
  }

  Widget _handleCurrentScreen() {
    bool seen = (prefs.getBool('seen') ?? false);
    if (seen) {
      return new RootScreen(prefs: prefs);
    } else {
      return new WalkThroughScreen(prefs: prefs);
    }
  }
}
