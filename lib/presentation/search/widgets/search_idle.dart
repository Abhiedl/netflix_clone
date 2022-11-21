import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:netflix/core/Constants/constants.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/presentation/search/widgets/title.dart';

const imageUrl =
    'https://www.themoviedb.org/t/p/w1920_and_h800_multi_faces/bZGAX8oMDm3Mo5i0ZPKh9G2OcaO.jpg';

class ScreenIdleWidget extends StatelessWidget {
  const ScreenIdleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SearchTextTitle(title: 'Top Searches'),
        kHeight,
        Expanded(
          child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) => const TopSearchItemTile(),
              separatorBuilder: (context, index) => kHeight20,
              itemCount: 10),
        ),
      ],
    );
  }
}

class TopSearchItemTile extends StatelessWidget {
  const TopSearchItemTile({super.key});

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          width: screenwidth * 0.39,
          height: 65,
          decoration: const BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(imageUrl),
          )),
        ),
        const Expanded(
          child: Text(
            'Loki Series',
            style: TextStyle(
                color: kWhite, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        const Icon(
          Icons.play_circle_outline_outlined,
          size: 50,
          color: Colors.white,
        )
      ],
    );
  }
}
