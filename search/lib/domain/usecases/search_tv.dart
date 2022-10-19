import 'package:dartz/dartz.dart';
import 'package:movie/utils/failure.dart';
import 'package:tvs/domain_tv/entities_tv/tv.dart';
import 'package:tvs/domain_tv/repositories_tv/tv_repository.dart';

class SearchTv {
  final TvRepository repository;

  SearchTv(this.repository);

  Future<Either<Failure, List<Tv>>> execute(String query) {
    return repository.searchTv(query);
  }
}
