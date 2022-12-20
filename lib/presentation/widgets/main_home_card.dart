import 'package:flutter/material.dart';
import 'package:netflix/core/constants.dart';

class MainHomeCard extends StatelessWidget {
  const MainHomeCard({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: 130,
        height: 250,
        decoration: BoxDecoration(
          borderRadius: kRadius,
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ));
  }
}
