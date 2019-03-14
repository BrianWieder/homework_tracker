import 'package:flutter/material.dart';

import '../components/course_creation.dart';
import '../components/course_join.dart';

class CourseNewScreen extends StatefulWidget {
  @override
  _CourseNewScreenState createState() => _CourseNewScreenState();
}

class _CourseNewScreenState extends State<CourseNewScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Homework Tracker'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Create',
              ),
              Tab(
                text: 'Join',
              )
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[CourseCreation(), CourseJoin()],
        ),
      ),
    );
  }
}
