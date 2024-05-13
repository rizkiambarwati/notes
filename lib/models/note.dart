import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  String? id;
  final String title;
  final String description;
  Timestamp? createdAt;
  Timestamp? updateAt;

  Npte({
    this.id;
    required this.title,
    required this.description,
    this.createdAt,
    this.updateAt,
  });

  factory Note.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Note (
      id: doc.id,
      title: data['title'],
      description: data['description'],
      createdAt: data['created_at'] as Timestamp,
      updateAt: data['updated_at'] as Timestamp,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'title': title,
      'description': description,
      'created_at': createdAt,
      'upadated_at': updateAt,
    };
  }
}
