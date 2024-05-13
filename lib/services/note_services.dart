import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes/models/note.dart';

class NoteService {
  static final FirebaseFirestore _database = FirebaseFirestore.instance;
  static final CollectionReference _notesCollection =
      _database.collection('notes');

  static Future<void> addNote(Note note) async {
    Map<String, dynamic> newNote = {
      'title': title,
      'description': description,
      'created_at': FieldValue.servrTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    };
    await _notesCollection.add(newNote);
  }

  static Future<void> updateNote(Note note) async {
    Map<String, dynamic> updatedNote = {
      'title': note.title,
      'description': note.description,
      'ceated_at': note.createdAt,
      'updated_at': FieldValue.serverTimestamp(),
    };
    await _notesCollection.doc(note.id).update(updatedNote);
  }

  static Future<void> deleteNote(Note note) async {
    await _notesCollection.doc(note.id).delete();
  }

  static Future<QuerySnapshot> retrieveNotes() {
    return _notesCollection.get();
  }

  static Stream<List<Note>> getNoteList() {
    return _notesCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Note(
          id: doc.id,
          title: data['title'],
          description: data['description'],
          createdAt: data['created_at'] != null
              ? data['created_at'] as Timestamp
              : null,
          updatedAt: data['updated_at'] != null
              ? data['updated_at'] as Timestamp
              : null,
        );
      }).toList();
    });
  }
}

  // final CollectionReference _database =
  //     FirebaseFirestore.instance.collection('note_list');

  // Stream<Map<String, String>> getNoteList() {
  //   return _database.snapshots().map((querySnapshot) {
  //     final Map<String, String> items = {};

  //     querySnapshot.docs.map((docScapshot) {
  //       final data = docScapshot.data() as Map<String, dynamic>;
  //       if (data.containsKey('title')) {
  //         Map<dynamic, dynamic> values = data as Map<dynamic, dynamic>;
  //         values.forEach((key, value) {
  //           items[key] = value['title'] as String;
  //         });
  //       }
  //     });
  //     return items;
  //   });
  // }

  // void addNoteList(String title, String description) {
  //   _database.doc().set({
  //     'title': title,
  //     'description': description,
  //   });
  // }

  // Future<void> removeNoteList(String key) async {
  //   await _database.doc(key).delete();
  // }
  //}
