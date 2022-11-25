import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/downloads/downloads_bloc.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/core/colors.dart';
import 'package:netflix/core/strings.dart';
import 'package:netflix/presentation/widgets/app_bar_widget.dart';

class ScreenDownloads extends StatelessWidget {
  ScreenDownloads({super.key});

  final _widgetList = [
    const _SmartDownloads(),
    Section2(),
    const Section3(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: AppBarWidget(title: "Downloads")),
        body: ListView.separated(
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) => _widgetList[index],
            separatorBuilder: (context, index) => const SizedBox(
                  height: 25,
                ),
            itemCount: _widgetList.length));
  }
}

class Section2 extends StatelessWidget {
  Section2({super.key});

  // final List imageList = [
  //   'https://www.themoviedb.org/t/p/w1280/pHkKbIRoCe7zIFvqan9LFSaQAde.jpg',
  //   'https://www.themoviedb.org/t/p/w1280/uJYYizSuA9Y3DCs0qS4qWvHfZg4.jpg',
  //   'https://www.themoviedb.org/t/p/w1280/ujr5pztc1oitbe7ViMUOilFaJ7s.jpg',
  // ];
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<DownloadsBloc>(context)
          .add(const DownloadsEvent.getDownloadsImages());
    });

    final Size size = MediaQuery.of(context).size;

    return Column(children: [
      const Text(
        'Introducing Downloads for you',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: kWhite,
          fontSize: 23,
          fontWeight: FontWeight.bold,
        ),
      ),
      kHeight,
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 18),
        child: Text(
          'We will download a personalized selection of\n movies and shows for you, so there\'s\n always something to watch on your\n device',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey,
          ),
        ),
      ),
      kHeight,
      BlocBuilder<DownloadsBloc, DownloadsState>(
        builder: (context, state) {
          return SizedBox(
            width: size.width,
            height: size.width,
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Stack(alignment: Alignment.center, children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey.withOpacity(0.3),
                      radius: size.width * 0.35,
                    ),
                    DownloadsImageWidget(
                      size: Size(size.width * 0.3, size.width * 0.48),
                      imageList:
                          "$imageAppendUrl${state.downloads[1].posterPath}",
                      margin: const EdgeInsets.only(left: 170, top: 50),
                      angle: 15,
                      radius: 7,
                    ),
                    DownloadsImageWidget(
                      size: Size(size.width * 0.3, size.width * 0.48),
                      imageList:
                          '$imageAppendUrl${state.downloads[3].posterPath}',
                      margin: const EdgeInsets.only(right: 170, top: 50),
                      angle: -15,
                      radius: 7,
                    ),
                    DownloadsImageWidget(
                      size: Size(size.width * 0.37, size.width * 0.56),
                      radius: 7,
                      imageList:
                          '$imageAppendUrl${state.downloads[2].posterPath}',
                      margin: const EdgeInsets.only(top: 18),
                    ),
                  ]),
          );
        },
      ),
    ]);
  }
}

class Section3 extends StatelessWidget {
  const Section3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: MaterialButton(
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              color: kButtonColorBlue,
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Set Up',
                  style: TextStyle(
                      color: kWhite, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
        kHeight,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: MaterialButton(
            onPressed: () {},
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            color: kWhite,
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'See what you can download',
                style: TextStyle(
                  color: kBlack,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _SmartDownloads extends StatelessWidget {
  const _SmartDownloads({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: Row(
        children: const [
          // kWidth,
          Icon(
            Icons.settings,
            color: kWhite,
          ),
          Text(
            'Smart Downloads',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class DownloadsImageWidget extends StatelessWidget {
  const DownloadsImageWidget({
    Key? key,
    this.angle = 0,
    required this.imageList,
    required this.margin,
    required this.size,
    this.radius = 10,
  }) : super(key: key);

  final String imageList;
  final double angle;
  final EdgeInsets margin;
  final Size size;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Transform.rotate(
        angle: angle * pi / 180,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(imageList),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
