import 'dart:core';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:census_app/models/user.dart';
import 'package:census_app/business/validator.dart';
import 'package:census_app/services/userService.dart';
import "package:census_app/ui/widgets/custom_text_field.dart";
import 'package:census_app/ui/widgets/custom_flat_button.dart';
import 'package:census_app/ui/widgets/custom_alert_dialog.dart';

class SignUpScreen extends StatefulWidget {
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _fullName = new TextEditingController();
  final TextEditingController _number = new TextEditingController();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  CustomTextField _nameField;
  CustomTextField _phoneField;
  CustomTextField _emailField;
  CustomTextField _passwordField;
  bool _blackVisible = false;
  VoidCallback onBackPress;
  VoidCallback navToLogin;
  VoidCallback onHomePress;

  @override
  void initState() {
    super.initState();

    onBackPress = () {
      Navigator.of(context).pop();
    };
    navToLogin = () {
      Navigator.of(context).pushNamed("/signin");
    };

    _nameField = new CustomTextField(
      baseColor: Colors.grey,
      borderColor: Colors.grey[400],
      errorColor: Colors.red,
      controller: _fullName,
      hint: "Full Name",
      validator: Validator.validateName,
    );
    _phoneField = new CustomTextField(
      baseColor: Colors.grey,
      borderColor: Colors.grey[400],
      errorColor: Colors.red,
      controller: _number,
      hint: "Phone Number",
      validator: Validator.validateNumber,
      inputType: TextInputType.number,
    );
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
                        "Create new account",
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
                      padding:
                          EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
                      child: _nameField,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                      child: _phoneField,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                      child: _emailField,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                      child: _passwordField,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 25.0, horizontal: 40.0),
                      child: CustomFlatButton(
                        title: "Register",
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        textColor: Colors.white,
                        onPressed: () {
                          _signUp(
                              email: _email.text,
                              phoneNumber: _number.text,
                              fullName: _fullName.text,
                              password: _password.text);
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


  void _signUp(
      {String fullName,
      String phoneNumber,
      String email,
      String password,
      BuildContext context}) async {
    if (Validator.validateName(fullName) &&
        Validator.validateEmail(email) &&
        Validator.validateNumber(phoneNumber) &&
        Validator.validatePassword(password)) {
      try {
        await UserAPI.createUser(new User(
                email: email,
                phoneNumber: phoneNumber,
                fullName: fullName,
                password: password))
            .then((response) {
          _showErrorAlert(
            title: "Registration Sucessful",
            content: "You'll be directed to the login screem",
            path: "signin"
          );
        });
      } catch (e) {
        _showErrorAlert(
          title: e,
          content: "Try Again",
        );

        print("Error in registration: $e");
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
