import 'package:flutter/material.dart';
import 'package:netflix/core/constants.dart';

class MainHomeCard extends StatelessWidget {
  const MainHomeCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: 130,
        height: 250,
        decoration: BoxDecoration(
          borderRadius: kRadius,
          image: const DecorationImage(
              image: NetworkImage(
                  "https://www.themoviedb.org/t/p/w1280/xf9wuDcqlUPWABZNeDKPbZUjWx0.jpg"),
              fit: BoxFit.cover),
        ));
  }
}
