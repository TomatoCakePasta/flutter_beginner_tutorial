import 'package:flutter/material.dart';
import 'package:flutter_beginner_tutorial/next_page.dart';
import 'package:flutter_beginner_tutorial/select_page.dart';
import 'package:flutter_beginner_tutorial/slide_show_page.dart';
import 'package:video_player/video_player.dart';

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
      home: const MyHomePage(title: 'Memory Way'),
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
        color: const Color.fromARGB(255, 199, 241, 227),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SlideShowPage())
                  );
                },
                child: Text(
                  "Memory Way",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
