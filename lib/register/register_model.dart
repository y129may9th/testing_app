import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RegisterModel extends ChangeNotifier {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? email;
  String? password;

  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    this.password = password;
    notifyListeners();
  }

  Future signUp() async {
    this.email = emailController.text;
    this.password = passwordController.text;

    // Firebase auth で認証のためのユーザー作成

    // Firestore にユーザのほか情報を保存
    // await FirebaseFirestore.instance.collection('books').doc(book.id).update({
    //   'title': title,
    //   'author': author,
    // });
  }
}
