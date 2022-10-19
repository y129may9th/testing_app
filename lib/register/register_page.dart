import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_app/register/register_model.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterModel>(
      create: (_) => RegisterModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Signup'),
        ),
        body: Center(
          child: Consumer<RegisterModel>(builder: (context, model, child) {
            return Column(
              children: [
                TextField(
                  controller: model.emailController,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                  onChanged: (text) {
                    model.setPassword(text);
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: model.passwordController,
                  decoration: const InputDecoration(
                    hintText: 'パスワード',
                  ),
                  onChanged: (text) {
                    model.setEmail(text);
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await model.signUp();
                      // Navigator.of(context).pop(model.title);
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
                  child: const Text('登録する'),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
