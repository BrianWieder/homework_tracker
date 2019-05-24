import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String name;
  String comment;

  DocumentReference reference;

  Comment(this.name, this.comment);

  Comment.fromMap(Map<String, dynamic> map, {this.reference}) {
    assert(map['name'] != null);
    assert(map['comment'] != null);
    name = map['name'];
    comment = map['comment'];
  }

  Comment.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}
