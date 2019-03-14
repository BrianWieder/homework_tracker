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
            Text(homework.dueDate.toString()),
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
                  Text('What pages is this?'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
