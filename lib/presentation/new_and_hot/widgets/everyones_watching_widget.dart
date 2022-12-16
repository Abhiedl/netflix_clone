import 'package:flutter/material.dart';
import 'package:netflix/core/strings.dart';
import 'package:netflix/presentation/widgets/video_widget.dart';

import '../../../core/constants.dart';
import '../../../core/colors.dart';
import '../../home/widgets/custom_button_widget.dart';

class EveryonesWatchingWidget extends StatelessWidget {
  final String backdropPath;
  final String movieName;
  final String description;
  const EveryonesWatchingWidget({
    Key? key,
    required this.backdropPath,
    required this.movieName,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kHeight,
        Text(
          movieName,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        kHeight,
        Text(
          description,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: kGrey),
        ),
        kHeight50,
        VideoWidget(
          url: '$imageAppendUrl$backdropPath',
        ),
        kHeight,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            CustomButtonWidget(
              icon: Icons.send,
              title: "Share",
              iconSize: 25,
              textSize: 16,
            ),
            kWidth,
            CustomButtonWidget(
              icon: Icons.add,
              title: "My List",
              iconSize: 25,
              textSize: 16,
            ),
            kWidth,
            CustomButtonWidget(
              icon: Icons.play_arrow,
              title: "Play",
              iconSize: 25,
              textSize: 16,
            ),
            kWidth,
          ],
        ),
        kHeight50,
      ],
    );
  }
}
