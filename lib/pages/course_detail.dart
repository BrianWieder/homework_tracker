import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../components/homework_card.dart';
import '../models/course.dart';
import '../models/homework.dart';

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
        body: _buildBody());
  }

  Widget _buildBody() {
    String courseId = course.courseId;
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection("courses/$courseId/homework")
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (BuildContext buildContext, int index) {
            Homework homework =
                Homework.fromSnapshot(snapshot.data.documents[index]);
            return HomeworkCard(homework);
          },
        );
      },
    );
  }
}
