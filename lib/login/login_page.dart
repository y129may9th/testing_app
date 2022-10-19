import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_app/login/login_model.dart';
import 'package:testing_app/register/register_page.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginModel>(
      create: (_) => LoginModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Center(
          child: Consumer<LoginModel>(builder: (context, model, child) {
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
                      await model.signIn();
                      // Navigator.of(context).pop(model.title);
                    } catch (e) {
                      final snackBar = SnackBar(
                        backgroundColor: Colors.red[200],
                        content: const Text(''),
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
                  child: const Text('ログイン'),
                ),
                TextButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterPage(),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                  child: const Text('新規登録の方はこちら'),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
