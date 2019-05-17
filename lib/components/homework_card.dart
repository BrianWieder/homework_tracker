import 'package:flutter/material.dart';

import '../models/homework.dart';

class HomeworkCard extends StatelessWidget {
  final Homework homework;

  HomeworkCard(this.homework);

  @override
  Widget build(BuildContext context) {
    return Card(
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
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: <Widget>[
                  Text('Brian Wieder: '),
                  Text('What pages is on?'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String getDueDateString(DateTime date) {
    return "Due on ${date.month}/${date.day}/${date.year}";
  }
}
