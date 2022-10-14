import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../domain/book.dart';

class BookListModel extends ChangeNotifier {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('books').snapshots();

  List<Book>? books;

  void fetchBoookList() {
    _usersStream.listen((QuerySnapshot snapshots) {
      final List<Book> books = snapshots.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
        print('passed');
        print(data);
        final String title = data['title'];
        final String author = data['author'];
        return Book(title, author);
      }).toList();

      this.books = books;
      notifyListeners();
    });
  }
}
