import 'package:dartz/dartz.dart';
import 'package:movie/utils/failure.dart';
import '../entities_tv/tv.dart';
import '../repositories_tv/tv_repository.dart';

class GetPopularTv {
  final TvRepository repository;

  GetPopularTv(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getPopularTv();
  }
}
