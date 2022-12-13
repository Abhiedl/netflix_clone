import 'package:dartz/dartz.dart';
import 'package:netflix/domain/core/failures/main_failure.dart';
import 'package:netflix/domain/new_and_hot/new_and_hot_resp/model/new_and_hot_resp.dart';

abstract class NewAndHotService {
  Future<Either<MainFailure, NewAndHotResp>> getNewAndHotMovieData();
  Future<Either<MainFailure, NewAndHotResp>> getNewAndHotTvData();
}
