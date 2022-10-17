import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../domain/book.dart';

// _xxxx はプライベート変数
class BookListModel extends ChangeNotifier {
  List<Book>? books;

  void fetchBoookList() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('books').get();

    final List<Book> books = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
      print('passed');
      print(data);
      final String title = data['title'];
      final String author = data['author'];

      return Book(title, author);
    }).toList();

    this.books = books;
    notifyListeners();
  }
}