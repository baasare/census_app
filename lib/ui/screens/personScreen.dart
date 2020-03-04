import 'package:census_app/models/person.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class PersonScreen extends StatelessWidget {
  final Person person;

  // In the constructor, require a Todo.
  PersonScreen({Key key, @required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    String imgUrl;

    if (person.gender == "M") {
      imgUrl = 'https://avataaars.io/?avatarStyle=Circle&topType=ShortHairTheCaesarSidePart&accessoriesType=Round&hatColor=Gray02&hairColor=Red&facialHairType=BeardLight&facialHairColor=BlondeGolden&clotheType=BlazerShirt&clotheColor=Gray02&eyeType=Wink&eyebrowType=RaisedExcited&mouthType=Disbelief&skinColor=DarkBrown';
    } else {
      imgUrl = 'https://avataaars.io/?avatarStyle=Circle&topType=LongHairStraight&accessoriesType=Blank&hairColor=BrownDark&facialHairType=Blank&clotheType=BlazerShirt&eyeType=Default&eyebrowType=Default&mouthType=Default&skinColor=Light';
    }


    return Stack(
      children: <Widget>[
        new Container(
          color: Colors.blue,
        ),
        new Image.network(
          imgUrl,
          fit: BoxFit.fill,
        ),
        new BackdropFilter(
            filter: new ui.ImageFilter.blur(
              sigmaX: 6.0,
              sigmaY: 6.0,
            ),
            child: new Container(
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.9),
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
              ),
            )),
        new Scaffold(
            appBar: new AppBar(
              title: new Text(""),
              centerTitle: false,
              elevation: 0.0,
              backgroundColor: Colors.transparent,
            ),
            backgroundColor: Colors.transparent,
            body: new Center(
              child: new Column(
                children: <Widget>[
                  new SizedBox(
                    height: _height / 12,
                  ),
                  new CircleAvatar(
                    radius: _width < _height ? _width / 4 : _height / 4,
                    backgroundImage: NetworkImage(imgUrl),
                  ),
                  new SizedBox(
                    height: _height / 25.0,
                  ),
                  new Text(
                    person.fullName,
                    style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: _width / 15,
                        color: Colors.white),
                  ),
                  new Padding(
                    padding: new EdgeInsets.only(
                        top: _height / 30, left: _width / 8, right: _width / 8),
                    child: new Text(
                      'Individual Info',
                      style: new TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: _width / 25,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  new Divider(
                    height: _height / 30,
                    color: Colors.white,
                  ),
                  new Row(
                    children: <Widget>[
                      rowCell(
                        "Age",
                        (person.age).toString(),
                      ),
                      rowCell("Nationality", person.nationality),
                      rowCell("Gender", person.gender),
                    ],
                  ),
                  new Divider(height: _height / 30, color: Colors.white),
                  new Row(
                    children: <Widget>[
                      rowCell("Ethnicity", person.ethnicity),
                      rowCell("Religion", person.religion),
                    ],
                  ),
                  new Divider(height: _height / 30, color: Colors.white),
                  new Row(
                    children: <Widget>[
                      rowCell("Location", person.ethnicity),
                      rowCell("Region", person.region),
                    ],
                  ),
                  new Divider(height: _height / 30, color: Colors.white),
                ],
              ),
            ))
      ],
    );
  }

  Widget rowCell(String count, String type) => new Expanded(
          child: new Column(
        children: <Widget>[
          new Text(
            count,
            style:
                new TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          new Text(type,
              style: new TextStyle(
                  color: Colors.white, fontWeight: FontWeight.normal))
        ],
      ));
}
