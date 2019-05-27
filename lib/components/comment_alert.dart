import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:homework_tracker/models/homework.dart';

class CommentAlert extends StatefulWidget {
  final Homework homework;

  CommentAlert(this.homework);

  @override
  CommentAlertState createState() => CommentAlertState();
}

class CommentAlertState extends State<CommentAlert> {
  String comment = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create a comment'),
      content: TextField(
        decoration: InputDecoration(labelText: 'Comment'),
        onChanged: (String comment) {
          setState(() {
            this.comment = comment;
          });
        },
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text('Post'),
          onPressed: () {
            FirebaseAuth.instance.currentUser().then((user) {
              this.widget.homework.reference.collection('comments').add({
                'name': user.displayName,
                'comment': this.comment
              }).then((comment) {
                Navigator.of(context).pop();
              });
            });
          },
        ),
      ],
    );
  }
}
