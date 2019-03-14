import 'package:flutter/material.dart';

import '../models/course.dart';

class CourseCard extends StatelessWidget {
  final Course course;

  CourseCard(this.course);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(course.courseName),
      subtitle: Text(course.members.toString()),
      onTap: () {
        String courseName = course.courseName;
        print("$courseName clicked!");
        Navigator.of(context).pushNamed("/course-detail", arguments: course);
      },
    );
  }
}
