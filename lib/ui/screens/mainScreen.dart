import 'package:flutter/material.dart';
import 'package:census_app/services/userService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:census_app/ui/screens/peopleScreen.dart';

class MainScreen extends StatefulWidget {
  final SharedPreferences prefs;

  MainScreen({this.prefs});

  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  PageController _myPage = PageController(initialPage: 0);

  String appBarTitle = "People";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        elevation: 0.5,
        leading: IconButton(
            icon: Icon(Icons.power_settings_new),
            onPressed: () {
              _logOut();
            }),
        title: Text(appBarTitle),
        centerTitle: true,
      ),
      body: PageView(
        controller: _myPage,
        onPageChanged: (int) {
          if (int == 0) {
            setState(() {
              appBarTitle = "People";
            });
          } else if (int == 1) {
            setState(() {
              appBarTitle = "Search";
            });
          }
        },

        children: <Widget>[
          Center(
            child: PeopleListScreen(widget.prefs.getString("token")),
          ),
          Center(
            child: Container(
              child: Text('Search'),
            ),
          )
        ],
//        physics: NeverScrollableScrollPhysics(), // Comment this if you need to use Swipe.
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 65.0,
        width: 65.0,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/addcitizen");
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
            elevation: 5.0,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 3.0,
        elevation: 5.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              padding: EdgeInsets.only(left: 35.0),
              icon: Icon(Icons.people_outline),
              onPressed: () {
                setState(() {
                  appBarTitle = "People";
                  _myPage.jumpToPage(0);
                });
              },
            ),
            IconButton(
              padding: EdgeInsets.only(right: 35.0),
              icon: Icon(Icons.search),
              onPressed: () {
                setState(() {
                  appBarTitle = "Search";
                  _myPage.jumpToPage(4);
                });
              },
            ),
          ],
        ),
        color: Colors.blue,
      ),
    );
  }

  void _logOut() async {
    UserAPI.logoutUser();
    Navigator.of(context).pushNamed("/root");
  }
}
