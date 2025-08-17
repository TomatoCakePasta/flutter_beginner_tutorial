import 'package:flutter/material.dart';
import 'package:flutter_beginner_tutorial/slide_show_controller.dart';
import 'package:flutter_beginner_tutorial/slide_show_view.dart';
import 'package:video_player/video_player.dart';

class SlideShowPage extends StatefulWidget {
  const SlideShowPage({super.key});

  @override
  State<SlideShowPage> createState() => _SlideShowPageState();
}

class _SlideShowPageState extends State<SlideShowPage> {

  final SlideShowController _controller = SlideShowController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlideShowView(
        controller: _controller,
      )
    );
  }
}