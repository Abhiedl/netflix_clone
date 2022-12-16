import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/core/colors.dart';
import 'package:netflix/core/strings.dart';
import 'package:netflix/presentation/home/widgets/custom_button_widget.dart';
import 'package:netflix/presentation/new_and_hot/widgets/coming_soon_widgets.dart';
import 'package:netflix/presentation/new_and_hot/widgets/everyones_watching_widget.dart';
import 'package:netflix/presentation/widgets/video_widget.dart';

import '../../application/new_and_hot/new_and_hot_bloc.dart';
import '../widgets/app_bar_widget.dart';

class ScreenNewAndHot extends StatelessWidget {
  const ScreenNewAndHot({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(90),
          child: AppBar(
            title: const Text(
              'New & Hot',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
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
            bottom: TabBar(
                isScrollable: true,
                unselectedLabelColor: kWhite,
                labelColor: kBlack,
                labelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                indicator: BoxDecoration(
                  color: kWhite,
                  borderRadius: kRadius30,
                ),
                tabs: const [
                  Tab(
                    text: "🍿 Coming Soon",
                  ),
                  Tab(
                    text: "👀 Everyone's Watching",
                  ),
                ]),
          ),
        ),
        body: const TabBarView(children: [
          ComingSoonList(),
          EveryonesWatchingList(),
        ]),
      ),
    );
  }
}

class ComingSoonList extends StatelessWidget {
  const ComingSoonList({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<NewAndHotBloc>(context).add(const LoadDataInComingSoon());
    });
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<NewAndHotBloc>(context)
            .add(const LoadDataInComingSoon());
      },
      child:
          BlocBuilder<NewAndHotBloc, NewAndHotState>(builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          );
        } else if (state.hasError) {
          return const Center(
            child: Text('Error while loading coming soon list.'),
          );
        } else if (state.comingSoonList.isEmpty) {
          return const Center(
            child: Text('Coming soon list empty.'),
          );
        } else {
          return ListView.builder(
              padding: EdgeInsets.only(top: 20),
              itemCount: state.comingSoonList.length,
              itemBuilder: (context, index) {
                final movie = state.comingSoonList[index];
                if (movie.id == null) {
                  return const SizedBox();
                }
                String month = '';
                String day = '';
                try {
                  final _date = DateTime.parse(movie.releaseDate!);
                  final formattedDate =
                      DateFormat.yMMMMd('en_US').format(_date);
                  month = formattedDate
                      .split(' ')
                      .first
                      .substring(0, 3)
                      .toUpperCase();
                  day = movie.releaseDate!.split('-')[1];
                } catch (_) {
                  month = '';
                  day = '';
                }

                return ComingSoonWidget(
                  id: movie.id.toString(),
                  day: day,
                  month: month,
                  backdropPath: '$imageAppendUrl${movie.backdropPath}',
                  movieName: movie.originalTitle ?? 'No title.',
                  description: movie.overview ?? 'No description.',
                );
              });
        }
      }),
    );
  }
}

class EveryonesWatchingList extends StatelessWidget {
  const EveryonesWatchingList({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<NewAndHotBloc>(context)
          .add(const LoadDataInEveryonesWatching());
    });

    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<NewAndHotBloc>(context)
            .add(const LoadDataInEveryonesWatching());
      },
      child: BlocBuilder<NewAndHotBloc, NewAndHotState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else if (state.hasError) {
            return const Center(
              child: Text('Error while loading coming soon list.'),
            );
          } else if (state.everyonesWatchingList.isEmpty) {
            return const Center(
              child: Text("Everyone's watching list emp"),
            );
          } else {
            return ListView.builder(
                padding: const EdgeInsets.all(15),
                itemCount: state.everyonesWatchingList.length,
                itemBuilder: (context, index) {
                  final movie = state.everyonesWatchingList[index];
                  log(movie.toString());
                  if (movie.id == null) {
                    return const SizedBox();
                  }

                  final tv = state.everyonesWatchingList[index];

                  return EveryonesWatchingWidget(
                      backdropPath: '$imageAppendUrl${tv.backdropPath}',
                      movieName: tv.originalName ?? 'No title available',
                      description: tv.overview ?? 'No description available');
                });
          }
        },
      ),
    );
  }
}
