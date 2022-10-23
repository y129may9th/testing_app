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
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
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
                          model.startLoading();
                          try {
                            await model.login();
                            Navigator.of(context).pop();
                          } catch (e) {
                            final snackBar = SnackBar(
                              backgroundColor: Colors.red[200],
                              content: Text(e.toString()),
                              action: SnackBarAction(
                                textColor: Colors.black,
                                label: 'Undo',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          } finally {
                            model.endLoading();
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
                  ),
                ),
                if (model.isLoading)
                  Container(
                    color: Colors.black54,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
              ],
            );
          }),
        ),
      ),
    );
  }
}
