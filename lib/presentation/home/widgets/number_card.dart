import 'dart:ui';

import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../core/Constants/constants.dart';

class NumberCard extends StatelessWidget {
  const NumberCard({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Row(
        children: [
          const SizedBox(
            width: 40,
            height: 150,
          ),
          Container(
              width: 130,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: kRadius,
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://www.themoviedb.org/t/p/w440_and_h660_face/62HCnUTziyWcpDaBO2i1DX17ljH.jpg"),
                ),
              )),
        ],
      ),
      Positioned(
        left: 13,
        bottom: 0,
        child: BorderedText(
          strokeWidth: 5,
          child: Text(
            "${index + 1}",
            style: const TextStyle(
              fontSize: 120,
              color: Colors.white,
              decoration: TextDecoration.none,
              decorationColor: Colors.white,
            ),
          ),
        ),
      )
    ]);
  }
}
