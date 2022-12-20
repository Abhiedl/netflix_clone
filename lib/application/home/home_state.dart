part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required String stateId,
    required List<NewAndHotData> pastYearMovieList,
    required List<NewAndHotData> trendingNowMovieList,
    required List<NewAndHotData> tenseDramasMovieList,
    required List<NewAndHotData> southIndianMovieList,
    required List<NewAndHotData> trendingTVList,
    required bool isLoading,
    required bool hasError,
  }) = _Initial;

  factory HomeState.initial() => const HomeState(
        pastYearMovieList: [],
        trendingNowMovieList: [],
        tenseDramasMovieList: [],
        southIndianMovieList: [],
        trendingTVList: [],
        isLoading: false,
        hasError: false,
        stateId: '0',
      );
}
