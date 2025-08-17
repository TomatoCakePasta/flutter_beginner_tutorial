import 'package:flutter/material.dart';

class NextPage extends StatelessWidget {
  NextPage({
    super.key,
    required this.text,
  });

  String text = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Next Page"),
      ),
      body: Container(
        alignment: Alignment.center,
        color: const Color.fromARGB(255, 222, 249, 239),
        child: Column(
          children: [
            Text(
              "${text}",
              style: TextStyle(
                fontSize: 100, 
                fontWeight: FontWeight.bold
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Go Back"),
            ),
          ],
        ),
      ),
    );
  }
}