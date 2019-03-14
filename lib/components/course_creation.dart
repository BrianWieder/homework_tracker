import 'package:flutter/material.dart';

class CourseCreation extends StatefulWidget {
  @override
  _CourseCreationState createState() => _CourseCreationState();
}

class _CourseCreationState extends State<CourseCreation> {
  GlobalKey<FormState> _courseCreationFormKey = GlobalKey();
  String className = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _courseCreationFormKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Class Name',
                hintText: 'AP Stat',
              ),
              validator: (value) => validator(value, 'Class Name'),
              onSaved: (value) => setState(() {
                    className = value;
                  }),
            ),
            RaisedButton(
              child: Text('Submit'),
              onPressed: () {
                if (_courseCreationFormKey.currentState.validate()) {
                  _courseCreationFormKey.currentState.save();
                }
              },
            )
          ],
        ),
      ),
    );
  }

  validator(String value, String inputName) {
    if (value.trim().length <= 0) {
      return 'You need a class name!';
    }
  }
}
