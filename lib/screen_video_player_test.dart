import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ScreenVideoPlayerTest extends StatefulWidget {
  const ScreenVideoPlayerTest({Key? key}) : super(key: key);

  @override
  _ScreenVideoPlayerTestState createState() => _ScreenVideoPlayerTestState();
}

class _ScreenVideoPlayerTestState extends State<ScreenVideoPlayerTest> {
  String url =
      "https://firebasestorage.googleapis.com/v0/b/fenua-xlife.appspot.com/o/Nesting.mp4?alt=media&token=0701479e-5620-4f6a-a78a-0fe6160a13b0";
  late VideoPlayerController _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.network(url)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : Container(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying ? _controller.pause() : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
