import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/home/home_bloc.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/core/colors.dart';
import 'package:netflix/core/strings.dart';
import 'package:netflix/presentation/home/widgets/background_card.dart';
import 'package:netflix/presentation/home/widgets/number_card.dart';
import 'package:netflix/presentation/home/widgets/number_title_card.dart';
import 'package:netflix/presentation/search/widgets/search_result.dart';
import 'package:netflix/presentation/widgets/main_home_card.dart';
import 'package:netflix/presentation/widgets/main_title.dart';

import '../../widgets/main_title_card.dart';
import 'custom_button_widget.dart';

ValueNotifier<bool> scrollNotifier = ValueNotifier(true);

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HomeBloc>(context).add(const GetHomeScreenData());
    });
    return Scaffold(
        body: ValueListenableBuilder(
      valueListenable: scrollNotifier,
      builder: (context, index, _) {
        return NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            final ScrollDirection direction = notification.direction;
            print(direction);
            if (direction == ScrollDirection.reverse) {
              scrollNotifier.value = false;
            } else if (direction == ScrollDirection.forward) {
              scrollNotifier.value = true;
            }
            return true;
          },
          child: Stack(
            children: [
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    );
                  } else if (state.hasError) {
                    return const Center(
                      child: Text('Error while loading data'),
                    );
                  }
                  final releasedPastYear = state.pastYearMovieList.map((e) {
                    return '$imageAppendUrl${e.posterPath}';
                  }).toList();
                  releasedPastYear.shuffle();
                  final trendingNowMovies = state.trendingNowMovieList.map((e) {
                    return '$imageAppendUrl${e.posterPath}';
                  }).toList();
                  trendingNowMovies.shuffle();
                  final top10tv = state.trendingTVList.map((e) {
                    return '$imageAppendUrl${e.posterPath}';
                  }).toList();
                  top10tv.shuffle();
                  final tenseDramas = state.tenseDramasMovieList.map((e) {
                    return '$imageAppendUrl${e.posterPath}';
                  }).toList();
                  tenseDramas.shuffle();
                  final southIndian = state.southIndianMovieList.map((e) {
                    return '$imageAppendUrl${e.posterPath}';
                  }).toList();
                  southIndian.shuffle();
                  return ListView(
                    children: [
                      const BackgroungCard(),
                      MainTitleCard(
                        title: 'Released in the Past Year',
                        posterList: releasedPastYear.sublist(0, 10),
                      ),
                      kHeight,
                      MainTitleCard(
                        title: 'Trending Now',
                        posterList: trendingNowMovies.sublist(0, 10),
                      ),
                      kHeight,
                      NumberTitleCard(
                        posterList: top10tv,
                      ),
                      kHeight,
                      MainTitleCard(
                        title: 'Tense Dramas',
                        posterList: tenseDramas.sublist(0, 10),
                      ),
                      kHeight,
                      MainTitleCard(
                        title: 'South Indian Cinema',
                        posterList: southIndian.sublist(0, 10),
                      ),
                    ],
                  );
                },
              ),
              scrollNotifier.value == true
                  ? AnimatedContainer(
                      duration: const Duration(milliseconds: 1000),
                      width: double.infinity,
                      height: 80,
                      color: Colors.black.withOpacity(0.3),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.network(
                                'https://cdn-images-1.medium.com/max/1200/1*ty4NvNrGg4ReETxqU2N3Og.png',
                                width: 50,
                                height: 50,
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.cast,
                                color: Colors.white,
                                size: 30,
                              ),
                              kWidth,
                              Container(
                                width: 28,
                                height: 25.7,
                                color: Colors.blue,
                              ),
                              kWidth
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('TV Shows', style: kHomeTitleText),
                              Text(
                                'Movies',
                                style: kHomeTitleText,
                              ),
                              Text(
                                'Categories',
                                style: kHomeTitleText,
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  : kHeight,
            ],
          ),
        );
      },
    ));
  }
}
