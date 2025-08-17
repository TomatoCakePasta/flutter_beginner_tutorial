import 'package:flutter/material.dart';
import 'package:flutter_beginner_tutorial/next_page.dart';
import 'package:flutter_beginner_tutorial/select_page.dart';

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

  int _selectedIndex = 0;
  final Duration _fadeDuration = const Duration(seconds: 2);
  final Duration _waitDuration = const Duration(seconds: 3);
  bool isPlaying = false;

  // URLのリスト
  final List<String> _urls = [
    "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
    "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg",
    "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-3.jpg",
  ];

  void _onStartSlideshow() {
    if (!isPlaying) {
      setState(() {
        isPlaying = true;
      });
      _onNextImage();
    }
    else {
      setState(() {
        isPlaying = false;
      });
    }
  }

  void _onNextImage() {
    setState(() {
      _selectedIndex = (_selectedIndex + 1) % _urls.length;
    });

    // フェード時間が終わったら次の画像へ
    Future.delayed(_fadeDuration + _waitDuration).then((_) {
      if (isPlaying) {
        _onNextImage();
      }
      else {
        return;
      }
    });
  }

  /// クロスディゾルブ付き画像表示
  Widget _buildCrossFadeImage() {
    return SizedBox(
      width: 300,
      height: 200,
      child: AnimatedSwitcher(
        duration: _fadeDuration, // フェード時間
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: Image.network(
          _urls[_selectedIndex],
          key: ValueKey<String>(_urls[_selectedIndex]), // 画像切替のトリガー
          fit: BoxFit.cover,
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        color: const Color.fromARGB(255, 222, 249, 239),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_urls[_selectedIndex]),
              _buildCrossFadeImage(),
              // button
              ElevatedButton(
                onPressed: _onStartSlideshow,
                child: Text(
                  isPlaying ? "Stop" : "Start",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
