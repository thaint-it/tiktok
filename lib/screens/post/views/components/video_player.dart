import 'package:flutter/material.dart';
import 'package:tiktok_clone/api/enpoints.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/utils/utils.dart';
import 'package:video_player/video_player.dart';

class TiktokVideoPlayer extends StatefulWidget {
  final String videoUrl;
  TiktokVideoPlayer({required this.videoUrl});

  @override
  State<TiktokVideoPlayer> createState() => _TiktokVideoPlayerState();
}

class _TiktokVideoPlayerState extends State<TiktokVideoPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the VideoPlayerController with the video URL
    _controller = VideoPlayerController.asset(Utils.getUrl(widget.videoUrl));
    // Initialize the controller and store the Future for later use
    // Optionally set the controller to loop
    // _controller.addListener(() {
    //   setState(() {});
    // });
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is removed from the widget tree
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: blackColor,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          VideoPlayer(_controller),
          ClosedCaption(text: _controller.value.caption.text),
          VideoProgressIndicator(_controller, allowScrubbing: true),
        ],
      ),
    );
  }
}
