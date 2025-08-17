import 'package:flutter/material.dart';
import 'package:flutter_beginner_tutorial/slide_show_controller.dart';
import 'package:video_player/video_player.dart';

class SlideShowView extends StatelessWidget {
  final SlideShowController controller;

  const SlideShowView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final media = controller.media[controller.selectedIndex];

    Widget mediaWidget;
    if (media["type"] == "video" &&
      controller.videoController != null &&
      controller.videoController!.value.isInitialized) {
        mediaWidget = AspectRatio(
          aspectRatio: controller.videoController!.value.aspectRatio,
          child: VideoPlayer(controller.videoController!),
          key: ValueKey(media["url"]),
        );
    }
    else if (media["type"] == "image") {
      mediaWidget = Image.asset(
        media["url"]!,
        fit: BoxFit.cover,
        key: ValueKey(media["url"]),
      );
    }
    else {
      mediaWidget = const SizedBox(
        width: 500,
        height: 500,
      );
    }

    return Scaffold (
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        title: const Text("Next Page"),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 175, 175, 175)),
      ),
      body: SafeArea(
        child: Container(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Text(media["url"]!),
              SizedBox(
                width: 500,
                height: 500,
                child: AnimatedSwitcher(
                  duration: controller.fadeDuration,
                  child: mediaWidget,
                ),
              ),
              ElevatedButton(
                onPressed: controller.startOrStopSlideShow,
                child: Text(controller.isPlaying ? "Stop" : "Start"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: controller.isPlaying
                      ? const Color.fromARGB(50, 255, 255, 255)
                      : const Color.fromARGB(255, 255, 255, 255),
                  foregroundColor: controller.isPlaying
                      ? const Color.fromARGB(180, 255, 254, 254)
                      : Colors.black,
                ),
              ),
            ],
          ),
        ),
        ),
      ),
    );
  }
}