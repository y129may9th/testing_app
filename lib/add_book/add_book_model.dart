import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddBookModel extends ChangeNotifier {
  String? title; // ? は null 許容
  String? author;
  File? imageFile;

  final ImagePicker picker = ImagePicker();

  Future addBook() async {
    if (title == null || title == '') {
      throw '本のタイトルが入力されていません。';
    }

    if (author == null || author!.isEmpty) {
      throw '著者が入力されていません。';
    }

    if (imageFile != null) {
      // Storage にアップロード
    }

    await FirebaseFirestore.instance.collection('books').add({
      'title': title,
      'author': author,
    });
  }

  Future imgFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      notifyListeners();
    }
  }
}
