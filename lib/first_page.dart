import 'package:flutter/material.dart';
import 'package:testing_app/second_page.dart';

class FirstPage extends StatelessWidget {
  String nameText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Page'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.network(
              //     'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
              TextField(
                onChanged: (text) {
                  print(text); // debug
                  nameText = text;
                },
                // obscureText: true, // パスワードみたいに隠すかどうか
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'input your name',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SecondPage(nameText),
                    ),
                  );
                },
                child: const Text('次の画面'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
