import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../components/course_card.dart';
import '../models/course.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

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
    Widget body;
    if (user != null) {
      body = _buildBody();
    } else {
      body = Container();
    }

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
        child: body,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed('/course-creation');
        },
      ),
    );
  }

  Widget _buildBody() {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection("courses")
          .where("members", arrayContains: user.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (BuildContext buildContext, int index) {
            Course course = Course.fromSnapshot(snapshot.data.documents[index]);
            return CourseCard(course);
          },
        );
      },
    );
  }
}
