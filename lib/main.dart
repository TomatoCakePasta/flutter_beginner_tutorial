import 'package:flutter/material.dart';
import 'package:flutter_beginner_tutorial/next_page.dart';
import 'package:flutter_beginner_tutorial/select_page.dart';
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

  VideoPlayerController? _videoController;

  final List<Map<String, String>> _media = [
    {"type": "image", "url": "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg"},
    {"type": "video", "url": "https://www.w3schools.com/html/mov_bbb.mp4"},
    {"type": "image", "url": "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg"},
    {"type": "image", "url": "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-3.jpg"},
  ];

  // URLのリスト
  final List<String> _urls = [
    "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
    "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg",
    "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-3.jpg",
  ];

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  // スライドショー再生停止
  void _onStartSlideshow() {
    if (!isPlaying) {
      setState(() {
        isPlaying = true;
      });
      _nextIndexAndContinue();
    }
    else {
      setState(() {
        isPlaying = false;
      });
    }
  }

  void _nextIndexAndContinue() {
    setState(() {
      _selectedIndex = (_selectedIndex + 1) % _media.length;
    });
    _onNextMedia();
  }

  void _onNextMedia() async {
    final media = _media[_selectedIndex];
    
    if (media["type"] == "video") {
      // 動画再生
      _videoController?.dispose();
      _videoController = VideoPlayerController.network(media["url"]!)
        ..initialize().then((_) {
          setState(() {
            _videoController!.play();
          });
        });

      // 動画の再生が終わったら次へ
      _videoController?.addListener(() {
        if (_videoController!.value.position >= _videoController!.value.duration) {
          _nextIndexAndContinue();
        }
      });
    }
    // 画像 -> fade -> wait
    else {
      Future.delayed(_fadeDuration + _waitDuration).then((_) {
        if (isPlaying) {
          _nextIndexAndContinue();
        }
      });
    }
  }

  /// クロスディゾルブ付き画像表示
  Widget _buildCrossFadeMedia() {
    final media = _media[_selectedIndex];
    Widget child;

    if (media["type"] == "video" && _videoController != null && _videoController!.value.isInitialized) {
      child = AspectRatio(
        aspectRatio: _videoController!.value.aspectRatio,
        child: VideoPlayer(_videoController!),
        key: ValueKey(media["url"]),
      );
    }
    else if (media["type"] == "image") {
      child = Image.network(
        media["url"]!,
        fit: BoxFit.cover,
        key: ValueKey(media["url"]),
      );
    }
    else {
      child = const SizedBox();
    }

    return SizedBox(
      width: 500,
      height: 500,
      child: AnimatedSwitcher(
        duration: _fadeDuration,
        child: child,
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
              _buildCrossFadeMedia(),
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
