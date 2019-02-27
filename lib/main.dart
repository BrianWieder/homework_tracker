import 'package:flutter/material.dart';

import './pages/login_screen.dart';

void main() => runApp(HomeworkTrackerApp());

class HomeworkTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}
