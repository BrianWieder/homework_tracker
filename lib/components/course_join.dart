import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CourseJoin extends StatefulWidget {
  @override
  _CourseJoinState createState() => _CourseJoinState();
}

class _CourseJoinState extends State<CourseJoin> {
  GlobalKey<FormState> _courseCreationFormKey = GlobalKey();
  String courseId;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _courseCreationFormKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Class ID',
                hintText: 'iZThh915lWWLPaNdo795',
              ),
              validator: (value) => validator(value, 'Class ID'),
              onSaved: (value) => setState(() {
                    courseId = value;
                  }),
            ),
            RaisedButton(
              child: Text('Submit'),
              onPressed: () {
                if (_courseCreationFormKey.currentState.validate()) {
                  _courseCreationFormKey.currentState.save();
                  FirebaseAuth.instance.currentUser().then((user) {
                    Firestore.instance
                        .document("courses/$courseId")
                        .updateData({
                      "members": FieldValue.arrayUnion([user.uid])
                    }).then((value) {
                      Navigator.of(context).pop();
                    }).catchError((err) {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("That is not a valid course ID"),
                        duration: Duration(seconds: 3),
                        action: SnackBarAction(
                          label: "Ok",
                          onPressed: () {},
                        ),
                      ));
                    });
                  });
                }
              },
            )
          ],
        ),
      ),
    );
  }

  validator(String value, String inputName) {
    if (value.trim().length <= 0) {
      return 'You need a class name!';
    }
  }
}
