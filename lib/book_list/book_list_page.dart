import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_app/add_book/add_book_page.dart';
import 'package:testing_app/book_list/book_list_model.dart';
import 'package:testing_app/domain/book.dart';

class BookList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookListModel>(
      create: (_) => BookListModel()..fetchBoookList(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('本一覧'),
        ),
        body: Center(
          child: Consumer<BookListModel>(builder: (context, model, child) {
            final List<Book>? books = model.books;

            if (books == null) {
              return CircularProgressIndicator();
            }

            final List<Widget> widgets = books
                .map(
                  (book) => ListTile(
                    title: Text(book.title),
                    subtitle: Text(book.author),
                  ),
                )
                .toList();
            return ListView(
              children: widgets,
            );
          }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddBookPage(),
                fullscreenDialog: true,
              ),
            );
          },
          tooltip: 'increment',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}