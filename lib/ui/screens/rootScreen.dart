//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:census_app/ui/screens/welcomeScreen.dart';
import 'package:census_app/ui/screens/mainScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RootScreen extends StatelessWidget {
  final SharedPreferences prefs;

  RootScreen({this.prefs});

  Future<bool> showMainPage() async {
    var prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool("is_logged_in");

    if (isLoggedIn == null) {
      isLoggedIn = false;
      return false;
    } else if (isLoggedIn == false) {
      return false;
    } else if (isLoggedIn == true) {
      return true;
    }

    print("Is Logged In: $isLoggedIn");
    return isLoggedIn;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: showMainPage(),
        builder: (buildContext, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data) {
              return new MainScreen(prefs: prefs);
            } else {
              return new WelcomeScreen();
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }
    );
  }


//  Widget build(BuildContext context) {
//    bool isLoggedIn = (prefs.getBool('is_logged_in') ?? true);
//    if (isLoggedIn) {
//      String token = prefs.getString('token');
//      return new MainScreen(token: token);
//    } else {
//      return new WelcomeScreen();
//    }
//  }
}
