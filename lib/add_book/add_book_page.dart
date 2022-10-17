import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_app/add_book/add_book_model.dart';
import 'package:testing_app/domain/book.dart';

class AddBookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddBookModel>(
      create: (_) => AddBookModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('本を追加'),
        ),
        body: Center(
          child: Consumer<AddBookModel>(builder: (context, model, child) {
            return Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    hintText: '本のタイトル',
                  ),
                  onChanged: (text) {
                    model.title = text;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  decoration: const InputDecoration(
                    hintText: '著者',
                  ),
                  onChanged: (text) {
                    model.author = text;
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await model.addBook();
                      Navigator.of(context).pop(true);
                    } catch (e) {
                      final snackBar = SnackBar(
                        backgroundColor: Colors.red[200],
                        content: const Text('本のタイトルが入力されていません。'),
                        action: SnackBarAction(
                          textColor: Colors.black,
                          label: 'Undo',
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: const Text('追加'),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
