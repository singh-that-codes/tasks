import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  //get collection of notes
  final CollectionReference notes =
      FirebaseFirestore.instance.collection('notes');

  //CREATE
  Future<void> addNote(String note, String description) {
    return notes.add(
      {
        'note': note,
        'description': description,
        'timestamp': Timestamp.now(),
      },
    );
  }

  //READ
  Stream<QuerySnapshot> getNotesStream() {
    final noteStream = notes.orderBy('timestamp', descending: true).snapshots();
    return noteStream;
  }

  //UPDATE
  Future<void> updateNote(String docID, String newNote, String newDescription) {
    return notes.doc(docID).update({
      'note': newNote,
      'description': newDescription,
      'timestamp': Timestamp.now(),
    });
  }

  //DELETE
  Future<void> deleteNote(String docID) {
    return notes.doc(docID).delete();
  }
}
