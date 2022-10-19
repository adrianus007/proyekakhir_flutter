import 'package:dartz/dartz.dart';
import 'package:movie/utils/failure.dart';
import '../entities_tv/tv_detail.dart';
import '../repositories_tv/tv_repository.dart';


class SaveWatchlistTv {
  final TvRepository repository;

  SaveWatchlistTv(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return repository.saveWatchlistTv(tv);
  }
}
