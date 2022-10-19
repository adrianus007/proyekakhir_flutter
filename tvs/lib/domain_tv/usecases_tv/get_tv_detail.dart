import 'package:dartz/dartz.dart';
import 'package:movie/utils/failure.dart';
import '../entities_tv/tv_detail.dart';
import '../repositories_tv/tv_repository.dart';

class GetTvDetail {
  final TvRepository repository;

  GetTvDetail(this.repository);

  Future<Either<Failure, TvDetail>> execute(int id) {
    return repository.getTvDetail(id);
  }
}
