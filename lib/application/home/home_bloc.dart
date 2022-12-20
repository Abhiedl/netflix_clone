import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/new_and_hot/new_and_hot_resp/model/new_and_hot_resp.dart';
import 'package:netflix/domain/new_and_hot/new_and_hot_resp/new_and_hot_services.dart';

import '../../domain/core/failures/main_failure.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final NewAndHotService _homeService;
  HomeBloc(this._homeService) : super(HomeState.initial()) {
    //on event getHomeScreen Data

    on<GetHomeScreenData>((event, emit) async {
      //send loading to UI
      emit(state.copyWith(
        isLoading: true,
        hasError: false,
      ));
      //get data

      final _movieResult = await _homeService.getNewAndHotMovieData();
      final _tvResult = await _homeService.getNewAndHotTvData();
      //transform data
      final _movieState = _movieResult.fold(
          (MainFailure failure) => HomeState(
              stateId: DateTime.now().millisecondsSinceEpoch.toString(),
              pastYearMovieList: [],
              trendingNowMovieList: [],
              tenseDramasMovieList: [],
              southIndianMovieList: [],
              trendingTVList: [],
              isLoading: false,
              hasError: true), (NewAndHotResp resp) {
        final pastYear = resp.results;
        final trendingMovies = resp.results;
        final tenseDramas = resp.results;
        final southIndian = resp.results;
        final trendingTV = resp.results;
        pastYear.shuffle();
        trendingMovies.shuffle();
        tenseDramas.shuffle();
        southIndian.shuffle();
        trendingTV.shuffle();
        return HomeState(
          stateId: DateTime.now().millisecondsSinceEpoch.toString(),
          pastYearMovieList: pastYear,
          trendingNowMovieList: trendingMovies,
          tenseDramasMovieList: tenseDramas,
          southIndianMovieList: southIndian,
          trendingTVList: state.trendingTVList,
          isLoading: false,
          hasError: false,
        );
      });
      emit(_movieState);
      final _tvState = _tvResult.fold(
          (MainFailure failure) => HomeState(
              pastYearMovieList: [],
              trendingNowMovieList: [],
              tenseDramasMovieList: [],
              southIndianMovieList: [],
              trendingTVList: [],
              isLoading: false,
              hasError: true,
              stateId: DateTime.now().millisecondsSinceEpoch.toString()),
          (NewAndHotResp resp) {
        final trendingTV = resp.results;

        return HomeState(
          stateId: DateTime.now().millisecondsSinceEpoch.toString(),
          pastYearMovieList: state.pastYearMovieList,
          trendingNowMovieList: state.trendingNowMovieList,
          tenseDramasMovieList: state.tenseDramasMovieList,
          southIndianMovieList: state.southIndianMovieList,
          trendingTVList: trendingTV,
          isLoading: false,
          hasError: false,
        );
      });
      emit(_tvState);
    });
  }
}
