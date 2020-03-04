import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:census_app/models/user.dart';
import 'package:census_app/models/user_login.dart';
import 'package:census_app/business/validator.dart';
import 'package:census_app/services/userService.dart';
import "package:census_app/ui/widgets/custom_text_field.dart";
import 'package:census_app/ui/widgets/custom_flat_button.dart';
import 'package:census_app/ui/widgets/custom_alert_dialog.dart';

class SignInScreen extends StatefulWidget {
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  CustomTextField _emailField;
  CustomTextField _passwordField;
  User loginResponse;
  bool _blackVisible = false;
  VoidCallback onBackPress;
  VoidCallback onHomePress;
  VoidCallback onLogInPress;

  Widget snackBar(String message, String path) {
    return SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {
          // Some code to undo the change.
          Navigator.of(context).pushNamed("/$path");
        },
      ),
    );
  }

  // Find the Scaffold in the widget tree and use
  // it to show a SnackBar.

  @override
  void initState() {
    super.initState();

    onBackPress = () {
      Navigator.of(context).pop();
    };
    onHomePress = () {
      Navigator.of(context).pushNamed("/main");
    };
    onLogInPress = () {
      Navigator.of(context).pushNamed("/signin");
    };

    _emailField = new CustomTextField(
      baseColor: Colors.grey,
      borderColor: Colors.grey[400],
      errorColor: Colors.red,
      controller: _email,
      hint: "E-mail Adress",
      inputType: TextInputType.emailAddress,
      validator: Validator.validateEmail,
    );
    _passwordField = CustomTextField(
      baseColor: Colors.grey,
      borderColor: Colors.grey[400],
      errorColor: Colors.red,
      controller: _password,
      obscureText: true,
      hint: "Password",
      validator: Validator.validatePassword,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPress,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Stack(
              alignment: Alignment.topLeft,
              children: <Widget>[
                ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 70.0, bottom: 10.0, left: 10.0, right: 10.0),
                      child: Text(
                        "Log In",
                        softWrap: true,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.lightBlue[200],
                          decoration: TextDecoration.none,
                          fontSize: 24.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: "OpenSans",
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 20.0, bottom: 10.0, left: 15.0, right: 15.0),
                      child: _emailField,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 10.0, bottom: 20.0, left: 15.0, right: 15.0),
                      child: _passwordField,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14.0, horizontal: 40.0),
                      child: CustomFlatButton(
                        title: "Log In",
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        textColor: Colors.white,
                        onPressed: () {
                          _emailLogin(
                              email: _email.text,
                              password: _password.text,
                              context: context);
                        },
                        splashColor: Colors.black12,
                        borderColor: Colors.lightBlue[200],
                        borderWidth: 0,
                        color: Colors.lightBlue[200],
                      ),
                    ),
                  ],
                ),
                SafeArea(
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: onBackPress,
                  ),
                ),
              ],
            ),
            Offstage(
              offstage: !_blackVisible,
              child: GestureDetector(
                onTap: () {},
                child: AnimatedOpacity(
                  opacity: _blackVisible ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 400),
                  curve: Curves.ease,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _emailLogin(
      {String email, String password, BuildContext context}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (Validator.validateEmail(email) &&
        Validator.validatePassword(password)) {
      try {
//        SystemChannels.textInput.invokeMethod('TextInput.hide');
//        _changeBlackVisible();
        await UserAPI.loginUser(new UserLogin(email: email, password: password))
            .then((response) {
          final user = userFromJson(response.body);
          if (response.statusCode == 200) {
            setState(() {
              pref.setString('token', user.token);
              pref.setString('userID', (user.id).toString());
              pref.setBool('is_logged_in', true);
            });
            _showErrorAlert(
              title: "Login Sucessful",
              content: "You'll be directed to the home screem",
              path: "main",
            );
          } else {
            _showErrorAlert(
              title: "Login Failed",
              content: "Try loggin in again",
              path: "signin",
            );
          }
        });
      } catch (e) {
//        SystemChannels.textInput.invokeMethod('TextInput.hide');
//        _changeBlackVisible();
        print("Error in email sign in: $e");
      }
    }
  }

  void _showErrorAlert({String title, String content, String path}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CustomAlertDialog(
          content: content,
          title: title,
          path: path,
        );
      },
    );
  }
}
