import 'package:flutter/material.dart';

import '../models/course.dart';

class CourseDetail extends StatefulWidget {
  @override
  _CourseDetailState createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> {
  Course course = Course("", [""], [""]);

  @override
  Widget build(BuildContext context) {
    course = ModalRoute.of(context).settings.arguments;
    String courseTitle = course.courseName;
    return Scaffold(
      appBar: AppBar(
        title: Text("Homework Tracker - $courseTitle"),
      ),
      body: ListView.builder(
        itemCount: course.homework.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    course.homework[index],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                  ),
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
        },
      ),
    );
  }
}
