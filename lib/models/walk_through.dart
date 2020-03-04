import "package:flutter/material.dart";

class WalkThrough {
  IconData icon;
  String title;
  String description;
  Widget extraWidget;
  
  WalkThrough({this.icon, this.title, this.description, this.extraWidget}) {
    if (extraWidget == null) {
      extraWidget = new Container();
    }
  }
}