import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/fast_laugh/fast_laugh_bloc.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/core/colors.dart';
import 'package:netflix/core/strings.dart';
import 'package:netflix/domain/downloads/models/downloads.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

class VideoListItemInheritedWidget extends InheritedWidget {
  final Widget widget;
  final Downloads moviedata;

  const VideoListItemInheritedWidget({
    required this.widget,
    required this.moviedata,
    super.key,
    required int index,
  }) : super(child: widget);

  @override
  bool updateShouldNotify(covariant VideoListItemInheritedWidget oldWidget) {
    return oldWidget.moviedata != moviedata;
  }

  static VideoListItemInheritedWidget? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<VideoListItemInheritedWidget>();
  }
}

class VideoListItem extends StatelessWidget {
  final int index;
  const VideoListItem({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final posterpath =
        VideoListItemInheritedWidget.of(context)?.moviedata.posterPath;
    return Stack(children: [
      FastLaughVideoPlayer(
          videoUrl: dummyVideoUrls[index % dummyVideoUrls.length],
          onStateChanged: (bool) {}),
      Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Left side
              CircleAvatar(
                backgroundColor: Colors.black.withOpacity(0.5),
                radius: 30,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.volume_off,
                    color: kWhite,
                    size: 30,
                  ),
                ),
              ),

              //Right side
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: posterpath == null
                        ? null
                        : NetworkImage("$imageAppendUrl$posterpath"),
                  ),
                  kHeight,
                  ValueListenableBuilder(
                    valueListenable: likedVideosIdsNotifier,
                    builder: (context, newLikedVideosIds, _) {
                      if (newLikedVideosIds.contains(index)) {
                        return GestureDetector(
                          onTap: () {
                            // BlocProvider.of<FastLaughBloc>(context)
                            // .add(UnlikeVideo(id: index));
                            likedVideosIdsNotifier.value.remove(index);
                            likedVideosIdsNotifier.notifyListeners();
                          },
                          child: const VideoActionWidget(
                            icon: Icons.favorite,
                            title: 'Liked',
                          ),
                        );
                      }
                      return GestureDetector(
                        onTap: () {
                          //   BlocProvider.of<FastLaughBloc>(context)
                          //      .add(LikeVideo(id: index));
                          likedVideosIdsNotifier.value.add(index);
                          likedVideosIdsNotifier.notifyListeners();
                        },
                        child: const VideoActionWidget(
                            icon: Icons.emoji_emotions, title: 'LOL'),
                      );
                    },
                  ),
                  const VideoActionWidget(
                    icon: Icons.add,
                    title: 'My List',
                  ),
                  GestureDetector(
                    onTap: () {
                      final movieUrl = VideoListItemInheritedWidget.of(context)
                          ?.moviedata
                          .posterPath;
                      if (movieUrl != null) {
                        Share.share(movieUrl);
                      }
                    },
                    child: const VideoActionWidget(
                      icon: Icons.share,
                      title: 'Share',
                    ),
                  ),
                  const VideoActionWidget(
                    icon: Icons.play_arrow,
                    title: 'Play',
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ]);
  }
}

class VideoActionWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  const VideoActionWidget({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        children: [
          Icon(
            icon,
            color: kWhite,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: kWhite,
            ),
          ),
        ],
      ),
    );
  }
}

class FastLaughVideoPlayer extends StatefulWidget {
  const FastLaughVideoPlayer(
      {super.key, required this.videoUrl, required this.onStateChanged});

  final String videoUrl;
  final void Function(bool isPlaying) onStateChanged;

  @override
  State<FastLaughVideoPlayer> createState() => _FastLaughVideoPlayerState();
}

class _FastLaughVideoPlayerState extends State<FastLaughVideoPlayer> {
  late VideoPlayerController _videoPlayerController;
  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    _videoPlayerController.initialize().then((value) {
      setState(() {
        _videoPlayerController.play();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: _videoPlayerController.value.isInitialized
          ? AspectRatio(
              aspectRatio: _videoPlayerController.value.aspectRatio,
              child: VideoPlayer(_videoPlayerController),
            )
          : const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }
}
