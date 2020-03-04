import 'dart:convert';

Person personFromJson(String str) => Person.fromJson(json.decode(str));

String personToJson(Person data) => json.encode(data.toJson());

class Person {
  int id;
  String fullName;
  String gender;
  int age;
  String nationality;
  String ethnicity;
  String religion;
  String locality;
  String region;
  int enumerator;

  Person({
    this.id,
    this.fullName,
    this.gender,
    this.age,
    this.nationality,
    this.ethnicity,
    this.religion,
    this.locality,
    this.region,
    this.enumerator,
  });

  factory Person.fromJson(Map<String, dynamic> json) => Person(
    id: json["id"] == null ? null : json["id"],
    fullName: json["full_name"],
    gender: json["gender"],
    age: json["age"],
    nationality: json["nationality"],
    ethnicity: json["ethnicity"],
    religion: json["religion"],
    locality: json["locality"],
    region: json["region"],
    enumerator: json["enumerator"],
  );

  Map<String, dynamic> toJson() => {
    "id":  id == null ? null : id,
    "full_name": fullName,
    "gender": gender,
    "age": age,
    "nationality": nationality,
    "ethnicity": ethnicity,
    "religion": religion,
    "locality": locality,
    "region": region,
    "enumerator": enumerator,
  };
}
