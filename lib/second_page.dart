import 'package:flutter/material.dart';
import 'package:testing_app/first_page.dart';
import 'package:testing_app/third_page.dart';

import 'book_list/book_list_page.dart';

class SecondPage extends StatelessWidget {
  SecondPage(this.name);
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('lib/assets/images/yuii.PNG'),
            Text(
              name,
              style: const TextStyle(
                fontSize: 30,
              ),
            ),
            _buildButton(context, '前の画面へ', FirstPage()),
            _buildButton(context, 'Third 画面へ', ThirdPage()),
            _buildButton(context, '本一覧へ', BookList()),
          ],
        ),
      ),
    );
  }
}

Widget _buildButton(context, String label, page) {
  return ElevatedButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => page,
        ),
      );
    },
    child: Text(label),
  );
}
