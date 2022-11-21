import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:netflix/core/Constants/constants.dart';
import 'package:netflix/core/colors/colors.dart';

class VideoListItem extends StatelessWidget {
  final int index;
  const VideoListItem({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        color: Colors.accents[index % Colors.accents.length],
      ),
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
                children: const [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      'https://www.themoviedb.org/t/p/w1280/uJYYizSuA9Y3DCs0qS4qWvHfZg4.jpg',
                    ),
                  ),
                  kHeight,
                  VideoActionWidget(icon: Icons.emoji_emotions, title: 'LOL'),
                  VideoActionWidget(icon: Icons.add, title: 'My List'),
                  VideoActionWidget(icon: Icons.share, title: 'Share'),
                  VideoActionWidget(icon: Icons.play_arrow, title: 'Play'),
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
