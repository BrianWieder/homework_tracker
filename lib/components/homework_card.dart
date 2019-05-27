import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:homework_tracker/models/comment.dart';

import '../models/homework.dart';
import './comment_alert.dart';

class HomeworkCard extends StatelessWidget {
  final Homework homework;

  HomeworkCard(this.homework);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return CommentAlert(homework);
            });
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                homework.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
              Text(getDueDateString(homework.dueDate)),
              Divider(),
              Text(
                "Comments:",
                style: TextStyle(fontSize: 18.0),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: homework.reference.collection("comments").snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return LinearProgressIndicator();
                  List<Widget> commentWidgets = List<Widget>();
                  for (int i = 0; i < snapshot.data.documents.length; i++) {
                    Comment comment =
                        Comment.fromSnapshot(snapshot.data.documents[i]);
                    commentWidgets.add(Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: <Widget>[
                          Text("${comment.name}: "),
                          Text(comment.comment),
                        ],
                      ),
                    ));
                  }
                  return Column(
                    children: commentWidgets,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getDueDateString(DateTime date) {
    return "Due on ${date.month}/${date.day}/${date.year}";
  }
}
