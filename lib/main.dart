import 'package:flutter/material.dart';
import 'package:flutter_beginner_tutorial/next_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 38, 137, 134)),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
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
      ),
    );
  }
}
