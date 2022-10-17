import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testing_app/domain/book.dart';

class EditBookModel extends ChangeNotifier {
  String? title;
  String? author;

  Future updateBook() async {
    if (title == null || title == '') {
      throw '本のタイトルが入力されていません。';
    }

    if (author == null || author!.isEmpty) {
      throw '著者が入力されていません。';
    }

    await FirebaseFirestore.instance.collection('books').add({
      'title': title,
      'author': author,
    });
  }
}
