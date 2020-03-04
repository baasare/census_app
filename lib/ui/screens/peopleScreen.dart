import 'package:flutter/material.dart';
import 'package:census_app/models/person.dart';
import 'package:census_app/services/peopleService.dart';
import 'package:census_app/ui/screens/personScreen.dart';

class PeopleListScreen extends StatelessWidget {
  final String token;

  PeopleListScreen(this.token);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Person>>(
      future: PeopleAPI.getPeople(token),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Person> data = snapshot.data;
          return _peopleListView(data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }

  ListView _peopleListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Card(
              child: ListTile(
                title: Text(data[index].fullName,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    )),
                subtitle: Text("Gender: " + data[index].gender +  ", Age: " + (data[index].age).toString()),
                leading: Icon(Icons.person,
                  color: Colors.blue[500],
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PersonScreen(person: data[index]),
                    ),
                  );
                  // do something
                },
              )
//            child: _tile(data[index].fullName, data[index].gender, data[index].age, Icons.perm_identity),
          );
        });
  }

  ListTile _tile(String fullName, String gender, int age, IconData icon, BuildContext context) =>
      ListTile(
        title: Text(fullName,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
        subtitle: Text("Gender: $gender, Age: $age"),
        leading: Icon(
          icon,
          color: Colors.blue[500],
        ),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {

          // do something
        },
      );
}
