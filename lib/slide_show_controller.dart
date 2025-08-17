import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SlideShowController extends ChangeNotifier {
  int selectedIndex = 0;
  final Duration fadeDuration = const Duration(seconds: 2);
  final Duration waitDuration = const Duration(seconds: 3);
  bool isPlaying = false;

  VideoPlayerController? videoController;

  final List<Map<String, String>> media = [
    {"type": "image", "url": "medias/image1.jpg"},
    {"type": "video", "url": "medias/video1.mp4"},
    {"type": "image", "url": "medias/image5.jpg"},
    {"type": "video", "url": "medias/video5.mp4"},
    {"type": "image", "url": "medias/image2.jpg"},
    {"type": "image", "url": "medias/image3.jpg"},
    {"type": "image", "url": "medias/image4.jpg"},
  ];

  // スライドショー再生停止
  void startOrStopSlideShow() {
    if (!isPlaying) {
      isPlaying = true;
      notifyListeners();
      _nextIndexAndContinue();
    }
    else {
      isPlaying = false;
      notifyListeners();
    }
  }

  void _nextIndexAndContinue() {
    selectedIndex = (selectedIndex + 1) % media.length;
    notifyListeners();
    _onNextMedia();
  }

  void _onNextMedia() async {
    final current = media[selectedIndex];

    if (current["type"] == "video") {
      // 動画再生
      // 前のコントローラを破棄
      videoController?.removeListener(_videoListener);
      videoController?.dispose();

      videoController = VideoPlayerController.asset(current["url"]!)
        ..initialize().then((_) {
          videoController!.play();
          notifyListeners();
        });

      // 動画の再生が終わったら次へ
      videoController?.addListener(_videoListener);
    }
    // 画像 -> fade -> wait
    else {
      Future.delayed(fadeDuration + waitDuration).then((_) {
        if (isPlaying) {
          _nextIndexAndContinue();
        }
      });
    }
  }


  void _videoListener() {
    if (videoController!.value.isInitialized &&
        !videoController!.value.isPlaying &&
        videoController!.value.position >= videoController!.value.duration) {
      _nextIndexAndContinue();
    }
  }

  @override
  void dispose() {
    videoController?.dispose();
    super.dispose();
  }
}