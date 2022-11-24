import 'package:flutter/material.dart';
import 'package:short_media_app/screens/screens.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../models/models.dart';

class CustomVideoPlayer extends StatefulWidget {
  final Post post;
  const CustomVideoPlayer({super.key, required this.post});

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
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
    return VisibilityDetector(
      key: Key(controller.dataSource),
      onVisibilityChanged: (VisibilityInfo) {
        if (VisibilityInfo.visibleFraction > 0.5) {
          controller.play();
        } else {
          if (mounted) {
            controller.pause();
          }
        }
      },
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (controller.value.isPlaying) {
              controller.pause();
            } else {
              controller.play();
            }
          });
        },
        child: AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: Stack(children: [
              VideoPlayer(controller),
              const Positioned.fill(
                  child: DecoratedBox(
                      decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Colors.black,
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 0.2, 0.8, 1.0]),
              ))),
              _buildVideoCaptions(context),
              _buildVideoActions(context), // buttons
            ])),
      ),
    );
  }

  Align _buildVideoActions(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        height: controller.value.size.height,
        width: MediaQuery.of(context).size.width * 0.2,
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            _VideoActions(
              icon: Icons.favorite,
              value: '11.4k',
            ),
            _VideoActions(
              icon: Icons.comment,
              value: '1.4k',
            ),
            _VideoActions(
              icon: Icons.share,
              value: '440',
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector _buildVideoCaptions(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProfileScreen.routeName,
            arguments: widget.post.user);
      },
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          height: 125,
          width: MediaQuery.of(context).size.width * 0.75,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '@${widget.post.user.userName}',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                widget.post.caption,
                maxLines: 3,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _VideoActions extends StatelessWidget {
  final IconData icon;
  final String value;
  const _VideoActions({Key? key, required this.icon, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: Ink(
            decoration: const ShapeDecoration(
                shape: CircleBorder(), color: Colors.black),
            child: IconButton(
              onPressed: () {},
              icon: Icon(icon),
              color: Colors.white,
            ),
          ),
        ),
        Text(
          value,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
