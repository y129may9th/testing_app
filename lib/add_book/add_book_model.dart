import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../domain/book.dart';

class AddBookModel extends ChangeNotifier {
  String? title; // ? は null 許容
  String? author;

  Future addBook() async {
    if (title == null) {
      throw '本のタイトルが入力されていません。';
    }

    if (author == null) {
      throw '著者が入力されていません。';
    }

    await FirebaseFirestore.instance.collection('books').add({
      'title': title,
      'author': author,
    });
  }
}
