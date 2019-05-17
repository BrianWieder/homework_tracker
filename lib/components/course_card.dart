import 'package:flutter/material.dart';

import '../models/course.dart';

class CourseCard extends StatelessWidget {
  final Course course;

  CourseCard(this.course);

  @override
  Widget build(BuildContext context) {
    String courseId = course.courseId;
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(course.courseName),
          subtitle: Text('Course ID: $courseId'),
          onTap: () {
            Navigator.of(context)
                .pushNamed("/course-detail", arguments: course);
          },
        ),
        Divider()
      ],
    );
  }
}
