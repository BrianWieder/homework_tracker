import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/course.dart';

class HomeworkNewScreen extends StatefulWidget {
  @override
  _HomeworkNewScreenState createState() => _HomeworkNewScreenState();
}

class _HomeworkNewScreenState extends State<HomeworkNewScreen> {
  GlobalKey<FormState> _homeworkCreationFromKey = GlobalKey();
  String homeworkTitle = '';
  DateTime dueDate = DateTime.now();
  Course course = Course("", [""], [""]);

  @override
  Widget build(BuildContext context) {
    course = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Homework Tracker"),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _homeworkCreationFromKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Homework Title'),
                validator: (value) => validator(value, "Homework title"),
                onSaved: (value) => setState(() {
                      homeworkTitle = value;
                    }),
              ),
              FlatButton(
                child: Text(
                  getDueDateString(dueDate),
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () async {
                  DateTime date = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      initialDate: DateTime.now(),
                      lastDate: DateTime(DateTime.now().year + 2));
                  if (date != null) {
                    setState(() {
                      dueDate = date;
                    });
                  }
                },
              ),
              RaisedButton(
                child: Text("Create Homework"),
                onPressed: () {
                  if (_homeworkCreationFromKey.currentState.validate()) {
                    _homeworkCreationFromKey.currentState.save();
                    FirebaseAuth.instance.currentUser().then((user) {
                      Firestore.instance
                          .collection("courses/${course.courseId}/homework")
                          .add({
                        "due_date": dueDate,
                        "title": homeworkTitle
                      }).then((homework) {
                        Navigator.of(context).pop();
                      });
                    });
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  validator(String value, String inputName) {
    if (value.trim().length <= 0) {
      return "$inputName is required!";
    }
  }

  String getDueDateString(DateTime date) {
    return "Due on ${date.month}/${date.day}/${date.year}";
  }
}
