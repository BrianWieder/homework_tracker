import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;

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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () async {
              String urlString = '';
              if (Platform.isAndroid) {
                urlString =
                    "sms:?body=Join%20my%20class%20on%20homework%20tracker!%0AThe%20course%20ID%20is%20${course.courseId}";
              } else if (Platform.isIOS) {
                urlString =
                    "sms:&body=Join%20my%20class%20on%20homework%20tracker!%0AThe%20course%20ID%20is%20${course.courseId}";
              }

              if (await canLaunch(urlString)) {
                launch(urlString);
              }
            },
          )
        ],
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .pushNamed("/homework-creation", arguments: course);
        },
      ),
    );
  }

  Widget _buildBody() {
    String courseId = course.courseId;
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection("courses/$courseId/homework")
          .where("due_date",
              isGreaterThanOrEqualTo:
                  DateTime.now().subtract(Duration(days: 1)))
          .orderBy("due_date")
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
