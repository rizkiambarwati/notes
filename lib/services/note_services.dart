import 'package:cloud_firestore/cloud_firestore.dart';

class NoteService {
  static final FirebaseFirestore _database = FirebaseFirestore.instance;
  static final CollectionReference _notesCollection =
      _database.collection('notes');

  static Future<void> addNote(String title, String description) async {
    Map<String, dynamic> newNote = {
      'title': title,
      'description': description,
    };
    await _notesCollection.add(newNote);
  }

  static Future<void> updateNote(
      String id, String title, String description) async {
    Map<String, dynamic> updateNote = {
      'title': title,
      'description': description,
    };
    await _notesCollection.doc(id).update(updateNote);
  }

  static Future<void> deleteNote(String id) async {
    await _notesCollection.doc(id).delete();
  }

  static Stream<List<Map<String, dynamic>>> getNoteList() {
    //Stream : Melakukan perubahan tanpa harus di refresh
    return _notesCollection.snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((docSnapshot) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        return {'id': docSnapshot.id, ...data};
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
