import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:testing_app/add_book/add_book_page.dart';
import 'package:testing_app/book_list/book_list_model.dart';
import 'package:testing_app/domain/book.dart';
import 'package:testing_app/edit_book/edit_book_page.dart';
import 'package:testing_app/login/login_page.dart';
import 'package:testing_app/main.dart';

class BookList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookListModel>(
      create: (_) => BookListModel()..fetchBookList(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('本一覧'),
          actions: [
            IconButton(
              onPressed: () async {
                //画面遷移
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                    fullscreenDialog: true,
                  ),
                );
              },
              icon: const Icon(Icons.person),
            )
          ],
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
                              ScaffoldMessengerState _scaffoldMessangerState =
                                  scaffoldKey.currentState!;
                              final String? title = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditBookPage(book),
                                ),
                              );

                              if (title != null) {
                                _scaffoldMessangerState.showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.green[200],
                                    content: Text('$titleを編集しました。'),
                                  ),
                                );
                              }

                              model.fetchBookList();
                            },
                            backgroundColor: Color(0xFF7BC043),
                            foregroundColor: Colors.white,
                            icon: Icons.archive,
                            label: '編集',
                          ),
                          SlidableAction(
                            onPressed: (BuildContext context) async {
                              await showConfirmDialog(context, book, model);
                            }, // delete
                            backgroundColor: Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.save,
                            label: '削除',
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: book.imgURL != null
                            ? Image.network(book.imgURL!)
                            : null,
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

  Future showConfirmDialog(
    BuildContext context,
    Book book,
    BookListModel model,
  ) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Text("削除の確認"),
          content: Text("『${book.title}』を削除しますか？"),
          actions: [
            Builder(builder: (context) {
              return TextButton(
                child: Text("いいえ"),
                onPressed: () => Navigator.pop(context),
              );
            }),
            Builder(builder: (context) {
              return TextButton(
                child: Text("はい"),
                onPressed: () async {
                  await model.deleteBook(book);
                  Navigator.pop(context);

                  ScaffoldMessengerState _scaffoldMessangerState =
                      scaffoldKey.currentState!;

                  _scaffoldMessangerState.showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red[300],
                      content: Text("『${book.title}』を削除しました"),
                    ),
                  );

                  model.fetchBookList();
                },
              );
            }),
          ],
        );
      },
    );
  }
}
