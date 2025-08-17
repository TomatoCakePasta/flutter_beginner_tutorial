import 'package:flutter/material.dart';
import 'package:flutter_beginner_tutorial/next_page.dart';

class SelectPage extends StatelessWidget {
  const SelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 222, 249, 239),
      width: double.infinity,
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Milk"),
          Text("Eggs"),
          Text("Bread"),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NextPage(text: "A"))
              );
            },
            child: const Text("A"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NextPage(text: "B"))
              );
            },
            child: const Text("B"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NextPage(text: "C"))
              );
            },
            child: const Text("C"),
          ),
        ],
      ),
    );
  }
}