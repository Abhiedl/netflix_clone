import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:netflix/core/Constants/constants.dart';

import '../../../core/colors/colors.dart';
import 'custom_button_widget.dart';

class BackgroungCard extends StatelessWidget {
  const BackgroungCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        width: double.infinity,
        height: 600,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(kMainImage),
          ),
        ),
      ),
      Positioned(
        right: 0,
        left: 0,
        bottom: 0,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const CustomButtonWidget(
                icon: Icons.add,
                title: 'My List',
              ),
              _playButton(),
              const CustomButtonWidget(
                icon: Icons.info,
                title: 'Info',
              )
            ],
          ),
        ),
      )
    ]);
  }
}

TextButton _playButton() {
  return TextButton.icon(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(kWhite),
    ),
    onPressed: () {},
    icon: const Icon(
      Icons.play_arrow,
      size: 25,
      color: kBlack,
    ),
    label: const Padding(
      padding: EdgeInsets.only(right: 10),
      child: Text(
        "Play",
        style: TextStyle(
          fontSize: 20,
          color: kBlack,
        ),
      ),
    ),
  );
}
