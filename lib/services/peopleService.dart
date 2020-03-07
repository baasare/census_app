import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:census_app/models/person.dart';
import 'package:shared_preferences/shared_preferences.dart';

String url = "https://web-census-api.herokuapp.com/api";

class PeopleAPI {
  static Future<http.Response> addPerson(Person person, String token) async {
    print(token);
    final response = await http.post('$url/people/',
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Token $token'
        },
        body: personToJson(person));
    if (response.statusCode == 201) {
      return response;
    } else {
      throw Exception('Failed to add person');
    }
  }

  static Future<List<Person>> getPeople(String token) async {
    final response = await http.get(
      "$url/people/",
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Token $token'
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      return jsonResponse.map((person) => new Person.fromJson(person)).toList();
    } else {
      String mess = json.decode(response.body);
      throw Exception('Failed to load people from API\n $mess');
    }
  }

  static Future<http.Response> deletePerson(int id) async {
    var prefs = await SharedPreferences.getInstance();
    bool token = prefs.getBool("token");
    final response = await http.delete(
      "$url/people/$id",
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Token $token',
      },
    );
    return response;
  }

  static Future<http.Response> updatePerson(Person person) async {
    var prefs = await SharedPreferences.getInstance();
    bool token = prefs.getBool("token");
    int userID = prefs.getInt("userID");
    person.enumerator = userID;
    final response = await http.put('$url/people/',
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Token $token',
        },
        body: personToJson(person));
    return response;
  }
}
