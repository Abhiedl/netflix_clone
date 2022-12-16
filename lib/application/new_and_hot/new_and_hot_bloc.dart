import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/core/failures/main_failure.dart';
import 'package:netflix/domain/new_and_hot/new_and_hot_resp/new_and_hot_services.dart';

import '../../domain/new_and_hot/new_and_hot_resp/model/new_and_hot_resp.dart';

part 'new_and_hot_event.dart';
part 'new_and_hot_state.dart';
part 'new_and_hot_bloc.freezed.dart';

@injectable
class NewAndHotBloc extends Bloc<NewAndHotEvent, NewAndHotState> {
  final NewAndHotService _newAndHotService;
  NewAndHotBloc(this._newAndHotService) : super(NewAndHotState.initial()) {
    //get hot and new movie data

    on<LoadDataInComingSoon>((event, emit) async {
      //send loading to ui
      emit(const NewAndHotState(
        comingSoonList: [],
        everyonesWatchingList: [],
        isLoading: true,
        hasError: false,
      ));

//get data from remote

      final _result = await _newAndHotService.getNewAndHotMovieData();

//data to state

      final newState = _result.fold((MainFailure failure) {
        return const NewAndHotState(
          comingSoonList: [],
          everyonesWatchingList: [],
          isLoading: false,
          hasError: true,
        );
      }, (NewAndHotResp resp) {
        return NewAndHotState(
          comingSoonList: resp.results!,
          everyonesWatchingList: state.everyonesWatchingList,
          isLoading: false,
          hasError: false,
        );
      });
      emit(newState);
    });

    //get hot and new tv data

    on<LoadDataInEveryonesWatching>((event, emit) async {
      //send loading to ui
      emit(const NewAndHotState(
        comingSoonList: [],
        everyonesWatchingList: [],
        isLoading: true,
        hasError: false,
      ));

      //get data from remote

      final _result = await _newAndHotService.getNewAndHotTvData();

      //data to state

      final _newState = _result.fold(
        (MainFailure failure) {
          return const NewAndHotState(
            comingSoonList: [],
            everyonesWatchingList: [],
            isLoading: false,
            hasError: true,
          );
        },
        (NewAndHotResp resp) {
          return NewAndHotState(
            comingSoonList: state.comingSoonList,
            everyonesWatchingList: resp.results!,
            isLoading: false,
            hasError: false,
          );
        },
      );
      emit(_newState);
    });
  }
}
