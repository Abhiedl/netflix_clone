import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:netflix/core/Constants/constants.dart';
import 'package:netflix/presentation/home/widgets/number_card.dart';
import 'package:netflix/presentation/home/widgets/number_title_card.dart';
import 'package:netflix/presentation/search/widgets/search_result.dart';
import 'package:netflix/presentation/widgets/main_home_card.dart';
import 'package:netflix/presentation/widgets/main_title.dart';

import '../../widgets/main_title_card.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: const [
            MainTitleCard(
              title: 'Released in the Past Year',
            ),
            kHeight,
            MainTitleCard(
              title: 'Trending Now',
            ),
            kHeight,
            NumberTitleCard(),
            kHeight,
            MainTitleCard(
              title: 'Tense Dramas',
            ),
            kHeight,
            MainTitleCard(
              title: 'South Indian Cinema',
            ),
          ],
        ),
      ),
    );
  }
}
