import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../components/course_card.dart';
import '../models/course.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

List<Course> courses = [
  Course("Linear", ["5VTaXlPLMobE0bRaW83g8iLZeZr1"], ["6.1", "6.2"]),
  Course("Stat", ["5VTaXlPLMobE0bRaW83g8iLZeZr1"], ["Stuff"])
];

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  FirebaseUser user;

  _MainScreenState() {
    _auth.onAuthStateChanged.listen((user) {
      if (user == null) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    });
    _auth.currentUser().then((user) => setState(() {
          this.user = user;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Homework Tracker"),
        actions: <Widget>[
          FlatButton(
            child: Text("Sign Out"),
            onPressed: () => _auth.signOut(),
          ),
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: courses.length,
          itemBuilder: (BuildContext buildContext, int index) {
            return CourseCard(courses[index]);
          },
        ),
      ),
    );
  }
}
