import 'package:flutter/material.dart';
import 'package:short_media_app/widgets/custom_video_player.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../models/models.dart';

class CustomVideoPlayerPreview extends StatefulWidget {
  final Post post;
  const CustomVideoPlayerPreview({super.key, required this.post});

  @override
  State<CustomVideoPlayerPreview> createState() =>
      _CustomVideoPlayerPreviewState();
}

class _CustomVideoPlayerPreviewState extends State<CustomVideoPlayerPreview> {
  late VideoPlayerController controller;

  @override
  void initState() {
    controller = VideoPlayerController.asset(widget.post.assetPath);
    controller.initialize().then((_) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (controller.value.isPlaying) {
            controller.pause();
          } else {
            controller.play();
          }
        });
      },
      onDoubleTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CustomVideoPlayer(post: widget.post)));
      },
      child: AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: Stack(children: [
            VideoPlayer(controller),
            Positioned.fill(
                child: DecoratedBox(
                    decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.5),
                    Colors.black,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 0.6, 1.0]),
            ))),
            Positioned(
              left: 10,
              bottom: 10,
              child: Row(
                children: [
                  Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '1.4k',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.white),
                  )
                ],
              ),
            )
          ])),
    );
  }
}
