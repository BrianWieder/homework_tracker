import 'package:cloud_firestore/cloud_firestore.dart';

class Homework {
  DateTime dueDate;
  String title;

  DocumentReference reference;

  Homework(this.title, this.dueDate);

  Homework.fromMap(Map<String, dynamic> map, {this.reference}) {
    assert(map['title'] != null);
    assert(map['due_date'] != null);
    title = map['title'];
    Timestamp tempTimestamp = map['due_date'] as Timestamp;
    dueDate = tempTimestamp.toDate();
  }

  Homework.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}
