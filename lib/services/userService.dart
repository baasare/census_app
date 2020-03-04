import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:census_app/models/user.dart';
import 'package:census_app/models/user_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

String url = "https://web-census-api.herokuapp.com/api";

class UserAPI {
  static Future<http.Response> createUser(User user) async {
    final response = await http.post("$url/register/",
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: userToJson(user));

    if (response.statusCode == 201) {
      return response;
    } else {
      throw Exception('Failed to register user');
    }
  }

  static Future<http.Response> loginUser(UserLogin user) async {
    final response = await http.post('$url/login/',
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: userLoginToJson(user));
    return response;
  }

  static Future<User> getUser(User user) async {
    final response = await http.get('$url/user/', headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: ''
    });
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      return userFromJson(response.body);
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to get user');
    }
  }

  static Future<User> updateUser(User user) async {
    final response = await http.post('$url/user/',
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: ''
        },
        body: userToJson(user));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      return userFromJson(response.body);
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to update user');
    }
  }

  static Future<void> logoutUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('token', null);
    pref.setBool('is_logged_in', false);
  }

  static String getExceptionText(Exception e) {
    if (e is PlatformException) {
      switch (e.message) {
        case 'There is no user record corresponding to this identifier. The user may have been deleted.':
          return 'User with this e-mail not found.';
          break;
        case 'The password is invalid or the user does not have a password.':
          return 'Invalid password.';
          break;
        case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
          return 'No internet connection.';
          break;
        case 'The email address is already in use by another account.':
          return 'Email address is already taken.';
          break;
        default:
          return 'Unknown error occured.';
      }
    } else {
      return 'Unknown error occured.';
    }
  }
}
