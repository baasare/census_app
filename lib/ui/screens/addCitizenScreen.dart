import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import "package:census_app/models/person.dart";
import 'package:census_app/services/peopleService.dart';
import 'package:census_app/ui/widgets/custom_flat_button.dart';
import 'package:census_app/ui/widgets/custom_alert_dialog.dart';

class AddCitizen extends StatefulWidget {
  AddCitizen({Key key, this.title, this.prefs}) : super(key: key);
  final String title;
  final SharedPreferences prefs;

  @override
  _AddCitizenState createState() => new _AddCitizenState();
}

class _AddCitizenState extends State<AddCitizen> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  final TextEditingController _fullName = new TextEditingController();
  final TextEditingController _genderInput = new TextEditingController();
  final TextEditingController _age = new TextEditingController();
  final TextEditingController _nationality = new TextEditingController();
  final TextEditingController _ethnicity = new TextEditingController();
  final TextEditingController _religion = new TextEditingController();
  final TextEditingController _locality = new TextEditingController();
  final TextEditingController _regionInput = new TextEditingController();

  VoidCallback onBackPress;

  List<String> _regions = <String>[
    '',
    'Upper West',
    'Upper East',
    'North East',
    'Savannah',
    'Northern',
    'Bono',
    'Bono East',
    'Ahafo',
    'Western North',
    'Oti',
    'Ashanti',
    'Eastern',
    'Volta',
    'Central',
    'Western',
    'Greater Accra',
  ];

  List<String> _genders = <String>[
    '',
    'Male',
    'Female',
  ];
  String _gender = '';
  String _region = '';

  Future myToken;


  @override
  void initState() {
    super.initState();
    onBackPress = () {
      Navigator.of(context).pop();
    };
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new SafeArea(
          top: false,
          bottom: false,
          child: new Form(
              key: _formKey,
              autovalidate: true,
              child: new ListView(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                children: <Widget>[
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.person),
                      hintText: 'Enter your full name',
                      labelText: 'Full Name',
                    ),
                    controller: _fullName,
                    inputFormatters: [new LengthLimitingTextInputFormatter(50)],
                    validator: (val) =>
                        val.isEmpty ? 'Full Name is required' : null,
                  ),
                  new FormField(
                    builder: (FormFieldState state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          icon: const Icon(Icons.perm_identity),
                          labelText: 'Gender',
                        ),
                        isEmpty: _gender == '',
                        child: new DropdownButtonHideUnderline(
                          child: new DropdownButton(
                            value: _gender,
                            isDense: true,
                            onChanged: (String newValue) {
                              setState(() {
//                                newContact.favoriteColor = newValue;
                                _gender = newValue;
                                state.didChange(newValue);
                              });
                            },
                            items: _genders.map((String value) {
                              return new DropdownMenuItem(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.calendar_today),
                      hintText: 'Enter individual age',
                      labelText: 'Age',
                    ),
                    controller: _age,
                    validator: (val) => val.isEmpty ? 'Age is required' : null,
//                    keyboardType: TextInputType.datetime,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.flag),
                      hintText: "Enter individual's nationality",
                      labelText: 'Nationality',
                    ),
                    controller: _nationality,
                    validator: (val) =>
                        val.isEmpty ? 'Nationality is required' : null,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.nature_people),
                      hintText: "Enter individual's ethnicity",
                      labelText: 'Ethnicity',
                    ),
                    controller: _ethnicity,
                    validator: (val) =>
                        val.isEmpty ? 'Ethnicity is required' : null,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.spa),
                      hintText: "Enter individual's religion",
                      labelText: 'Religion',
                    ),
                    controller: _religion,
                    validator: (val) =>
                        val.isEmpty ? 'Religion is required' : null,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.location_on),
                      hintText: "Enter individual's locality",
                      labelText: 'Locality',
                    ),
                    controller: _locality,
                    validator: (val) =>
                        val.isEmpty ? 'Locality is required' : null,
                  ),
                  new FormField(
                    builder: (FormFieldState state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          icon: const Icon(Icons.perm_identity),
                          labelText: 'Region',
                        ),
                        isEmpty: _region == '',
                        child: new DropdownButtonHideUnderline(
                          child: new DropdownButton(
                            value: _region,
                            isDense: true,
                            onChanged: (String newValue) {
                              setState(() {
//                                newContact.favoriteColor = newValue;
                                _region = newValue;
                                state.didChange(newValue);
                              });
                            },
                            items: _regions.map((String value) {
                              return new DropdownMenuItem(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                  new Container(
                      padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                      child: CustomFlatButton(
                        title: "Submit",
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        textColor: Colors.white,
                        onPressed: () {
                          _addPerson(
                              fullName: _fullName.text,
                              gender: _gender,
                              age: int.parse(_age.text),
                              nationality: _nationality.text,
                              ethnicity: _ethnicity.text,
                              region: _region,
                              locality: _locality.text,
                              religion: _religion.text,
                              context: context);
                        },
                        splashColor: Colors.black12,
                        borderColor: Colors.lightBlue[200],
                        borderWidth: 0,
                        color: Colors.lightBlue[200],
                      )),
                ],
              ))),
    );
  }

  void _addPerson(
      {String fullName,
      String gender,
      int age,
      String nationality,
      String ethnicity,
      String religion,
      String locality,
      String region,
      BuildContext context}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String userID = pref.getString("userID");
    String token = pref.getString("token");


    if (gender == "Male") {
      gender = "M";
    } else {
      gender = "F";
    }

    if (region == "Upper West") {
      region = "UW";
    } else if (region == "Upper East") {
      region = "UE";
    } else if (region == "North East") {
      region = "NE";
    } else if (region == "Savannah") {
      region = "S";
    } else if (region == "Northern") {
      region = "N";
    } else if (region == "Bono") {
      region = "B";
    } else if (region == "Bono East") {
      region = "BE";
    } else if (region == "Ahafo") {
      region = "AH";
    } else if (region == "Western North") {
      region = "WN";
    } else if (region == "Oti") {
      region = "O";
    } else if (region == "Ashanti") {
      region = "AS";
    } else if (region == "Eastern") {
      region = "ES";
    } else if (region == "Volta") {
      region = "VL";
    } else if (region == "Central") {
      region = "CL";
    } else if (region == "Western") {
      region = "WS";
    } else if (region == "Greater Accra") {
      region = "GA";
    }
    try {
      await PeopleAPI.addPerson(
              new Person(
                  fullName: fullName,
                  gender: gender,
                  age: age,
                  nationality: nationality,
                  ethnicity: ethnicity,
                  religion: religion,
                  locality: locality,
                  region: region,
                  enumerator: int.parse(userID)),
          token)
          .then((response) {
        _showErrorAlert(
          title: "Individual Added Successfully",
          content: "You'll be redirected home",
          path: "main",
        );
      });
    } catch (e) {
      _showErrorAlert(
        title: e.toString(),
        content: "Individual was not added",
        path: "addcitizen",
      );
      String err = e.toString();
      print("Error in adding person: $err");
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
