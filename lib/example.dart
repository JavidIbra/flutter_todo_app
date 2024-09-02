import 'package:flutter/material.dart';

List<String> todo = ["test", "youtube", "testtttt"];

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ListView.builder(
            itemCount: todo.length,
            itemBuilder: (context, index) {
              return Text(todo[index]);
            },
          ),
        ),
      ),
    );
  }
}
