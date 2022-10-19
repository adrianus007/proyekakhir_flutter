import 'package:dartz/dartz.dart';
import 'package:movie/utils/failure.dart';
import '../entities_tv/tv.dart';
import '../repositories_tv/tv_repository.dart';

class GetTvRecommendations {
  final TvRepository repository;

  GetTvRecommendations(this.repository);

  Future<Either<Failure, List<Tv>>> execute(id) {
    return repository.getTvRecommendations(id);
  }
}
