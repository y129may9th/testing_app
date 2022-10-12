import 'package:flutter/material.dart';

class BookList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('本一覧'),
      ),
      body: const Center(
        child: Text('本一覧'),
      ),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        tooltip: 'increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
