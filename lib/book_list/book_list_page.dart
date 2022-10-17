import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:testing_app/add_book/add_book_page.dart';
import 'package:testing_app/book_list/book_list_model.dart';
import 'package:testing_app/domain/book.dart';
import 'package:testing_app/edit_book/edit_book_page.dart';

class BookList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookListModel>(
      create: (_) => BookListModel()..fetchBookList(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('本一覧'),
        ),
        body: Center(
          child: Consumer<BookListModel>(
            builder: (context, model, child) {
              final List<Book>? books = model.books;

              if (books == null) {
                return CircularProgressIndicator();
              }

              final List<Widget> widgets = books
                  .map(
                    (book) => Slidable(
                      endActionPane: ActionPane(
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            flex: 1,
                            onPressed: (BuildContext context) async {
                              final bool? added = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditBookPage(book),
                                ),
                              );

                              if (added != null && added) {
                                final snackBar = SnackBar(
                                  backgroundColor: Colors.green[200],
                                  content: const Text('編集しました。'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }

                              model.fetchBookList();
                            },
                            backgroundColor: Color(0xFF7BC043),
                            foregroundColor: Colors.white,
                            icon: Icons.archive,
                            label: '編集',
                          ),
                          SlidableAction(
                            onPressed: (BuildContext context) {
                              // 削除
                            }, // delete
                            backgroundColor: Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.save,
                            label: '削除',
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(book.title),
                        subtitle: Text(book.author),
                      ),
                    ),
                  )
                  .toList();
              return ListView(
                children: widgets,
              );
            },
          ),
        ),
        floatingActionButton:
            Consumer<BookListModel>(builder: (context, model, child) {
          return FloatingActionButton(
            onPressed: () async {
              final bool? added = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddBookPage(),
                  fullscreenDialog: true,
                ),
              );

              if (added != null && added) {
                final snackBar = SnackBar(
                  backgroundColor: Colors.green[200],
                  content: const Text('追加しました！'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }

              model.fetchBookList();
            },
            tooltip: 'increment',
            child: Icon(Icons.add),
          );
        }),
      ),
    );
  }
}
