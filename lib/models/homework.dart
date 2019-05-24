import 'package:cloud_firestore/cloud_firestore.dart';
import './comment.dart';

class Homework {
  DateTime dueDate;
  String title;
  List<Comment> comments;

  DocumentReference reference;

  Homework(this.title, this.dueDate);

  Homework.fromMap(Map<String, dynamic> map, {this.reference}) {
    assert(map['title'] != null);
    assert(map['due_date'] != null);
    title = map['title'];
    if (map['due_date'].runtimeType == DateTime) {
      dueDate = map['due_date'];
    } else {
      Timestamp tempTimestamp = map['due_date'] as Timestamp;
      dueDate = tempTimestamp.toDate();
    }
  }

  Homework.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}
