import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/new_and_hot/new_and_hot_resp/model/new_and_hot_resp.dart';

import 'package:netflix/domain/core/failures/main_failure.dart';

import 'package:dartz/dartz.dart';

import '../../domain/core/api_end_points.dart';
import '../../domain/new_and_hot/new_and_hot_resp/new_and_hot_services.dart';
import '../../domain/search/models/search_response/search_response.dart';

@LazySingleton(as: NewAndHotService)
class NewAndHotImpl implements NewAndHotService {
  @override
  Future<Either<MainFailure, NewAndHotResp>> getNewAndHotMovieData() async {
    try {
      final response = await Dio(BaseOptions()).get(
        ApiEndPoints.newAndHotMovieCS,
      );
      //log(response.data.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = NewAndHotResp.fromJson(response.data);
        log(result.toString());
        return Right(result);
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } catch (e) {
      log(e.toString());
      return const Left(MainFailure.clientFailure());
    }
  }

  @override
  Future<Either<MainFailure, NewAndHotResp>> getNewAndHotTvData() async {
    try {
      final response = await Dio(BaseOptions()).get(
        ApiEndPoints.newAndHotMovieEW,
      );
      log(response.data.toString());

      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = NewAndHotResp.fromJson(response.data);
        log(result.toString());
        return Right(result);
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } catch (e) {
      log(e.toString());
      return const Left(MainFailure.clientFailure());
    }
  }
}
