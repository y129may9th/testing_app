import 'package:flutter/material.dart';

class ThirdPage extends StatelessWidget {
  final List<String> entries = <String>['A', 'B', 'C', 'yui', 'Lia'];
  final List<int> colorCodes = <int>[600, 500, 100, 200, 300];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Third Page'),
      ),
      body: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(8),
            itemCount: entries.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 50,
                color: Colors.amber[colorCodes[index]],
                child: Center(
                  child: Text(
                    'Entry ${entries[index]}',
                  ),
                ),
              );
            },
          ),
          Column(
            children: [
              const Text(
                'ここが３ページ目da',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('前の画面へ'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
