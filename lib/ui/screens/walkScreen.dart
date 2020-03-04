import 'package:flutter/material.dart';
import "package:flutter_swiper/flutter_swiper.dart";
import "package:census_app/models/walk_through.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'package:census_app/ui/widgets/custom_flat_button.dart';

class WalkThroughScreen extends StatefulWidget {
  final SharedPreferences prefs;
  final List<WalkThrough> pages = [
    WalkThrough(
      icon: Icons.developer_mode,
      title: "Census Onboarding",
      description:
      "Record citizen data using this app.",
    ),
    WalkThrough(
      icon: Icons.layers,
      title: "Security",
      description: "Guard data recorded.",
    ),
    WalkThrough(
      icon: Icons.account_circle,
      title: "Secure Login",
      description:
      "Leverage secure log in using our security features.",
    ),
  ];

  WalkThroughScreen({this.prefs});

  @override
  _WalkThroughScreenState createState() => _WalkThroughScreenState();
}

class _WalkThroughScreenState extends State<WalkThroughScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Swiper.children(
        autoplay: false,
        index: 0,
        loop: false,
        pagination: new SwiperPagination(
          margin: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 40.0),
          builder: new DotSwiperPaginationBuilder(
              color: Colors.white30,
              activeColor: Colors.white,
              size: 6.5,
              activeSize: 8.0),
        ),
        control: SwiperControl(
          iconPrevious: null,
          iconNext: null,
        ),
        children: _getPages(context),
      ),
    );
  }

  List<Widget> _getPages(BuildContext context) {
    List<Widget> widgets = [];
    for (int i = 0; i < widget.pages.length; i++) {
      WalkThrough page = widget.pages[i];
      widgets.add(
        new Container(
          color: Colors.lightBlue[200],
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 70.0),
                child: Icon(
                  page.icon,
                  size: 125.0,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.only(top: 50.0, right: 15.0, left: 15.0),
                child: Text(
                  page.title,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                    fontFamily: "OpenSans",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  page.description,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w300,
                    fontFamily: "OpenSans",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: page.extraWidget,
              )
            ],
          ),
        ),
      );
    }
    widgets.add(
      new Container(
        color: Colors.lightBlue[200],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.code,
                size: 125.0,
                color: Colors.white,
              ),
              Padding(
                padding:
                const EdgeInsets.only(top: 50.0, right: 15.0, left: 15.0),
                child: Text(
                  "Jump straight into the action.",
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                    fontFamily: "OpenSans",
                  ),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.only(top: 20.0, right: 15.0, left: 15.0),
                child: CustomFlatButton(
                  title: "Get Started",
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  textColor: Colors.white,
                  onPressed: () {
                    widget.prefs.setBool('seen', true);
                    Navigator.of(context).pushNamed("/root");
                  },
                  splashColor: Colors.black12,
                  borderColor: Colors.white,
                  borderWidth: 2,
                  color: Colors.lightBlue[200],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    return widgets;
  }
}
