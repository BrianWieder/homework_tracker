import 'package:cloud_firestore/cloud_firestore.dart';

class Course {
  String courseName;
  String courseId;
  List<String> members;
  List<String> homework;

  DocumentReference reference;

  Course(this.courseName, this.members, this.homework);

  Course.fromMap(Map<String, dynamic> map, {this.reference}) {
    assert(map['course_name'] != null);
    assert(map['members'] != null);
    courseName = map['course_name'];
    courseId = this.reference.documentID;
    members = List<String>();
    for (var member in map['members']) {
      members.add(member as String);
    }
  }

  Course.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}
