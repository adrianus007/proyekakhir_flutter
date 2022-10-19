import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:movie/data/datasources/db/database_helper.dart';
import 'package:movie/data/datasources/movie_local_data_source.dart';
import 'package:movie/data/datasources/movie_remote_data_source.dart';
import 'package:movie/data/repositories/movie_repository_impl.dart';
import 'package:movie/domain/repositories/movie_repository.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';
import 'package:movie/presentation/bloc/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/movie_recommendations_bloc.dart';
import 'package:movie/presentation/bloc/now_playing_movie_bloc.dart';
import 'package:movie/presentation/bloc/popular_movies_bloc.dart';
import 'package:movie/presentation/bloc/top_rated_movies_bloc.dart';
import 'package:movie/presentation/bloc/watchlist_movie_bloc.dart';
import 'package:movie/utils/ssl_pining.dart';
import 'package:search/domain/usecases/search_tv.dart';
import 'package:search/presentation/movies_bloc/search_movies_bloc.dart';
import 'package:search/presentation/tvs_bloc/search_bloc.dart';
import 'package:tvs/data_tv/datasources/db/database_helper_tv.dart';
import 'package:tvs/data_tv/datasources/tv_local_data_source.dart';
import 'package:tvs/data_tv/datasources/tv_remote_data_source.dart';
import 'package:tvs/data_tv/repositories/tv_repository_impl.dart';
import 'package:tvs/domain_tv/repositories_tv/tv_repository.dart';
import 'package:tvs/domain_tv/usecases_tv/get_on_air_tv.dart';
import 'package:tvs/domain_tv/usecases_tv/get_popular_tv.dart';
import 'package:tvs/domain_tv/usecases_tv/get_top_rated_tv.dart';
import 'package:tvs/domain_tv/usecases_tv/get_tv_detail.dart';
import 'package:tvs/domain_tv/usecases_tv/get_tv_recommendations.dart';
import 'package:tvs/domain_tv/usecases_tv/get_watchlist_status_tv.dart';
import 'package:tvs/domain_tv/usecases_tv/get_watchlist_tv.dart';
import 'package:tvs/domain_tv/usecases_tv/remove_watchlist_tv.dart';
import 'package:tvs/domain_tv/usecases_tv/save_watchlist_tv.dart';
import 'package:get_it/get_it.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:tvs/presentation_tv/bloc_tv/on_air_tv_bloc.dart';
import 'package:tvs/presentation_tv/bloc_tv/popular_tv_bloc.dart';
import 'package:tvs/presentation_tv/bloc_tv/top_rated_tv_bloc.dart';
import 'package:tvs/presentation_tv/bloc_tv/tv_detail_bloc.dart';
import 'package:tvs/presentation_tv/bloc_tv/tv_recommendations_bloc.dart';
import 'package:tvs/presentation_tv/bloc_tv/watchlist_tv_bloc.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // bloc

  locator.registerFactory<NowPlayingMovieBloc>(
        () => NowPlayingMovieBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => MovieRecommendationsBloc(
      locator(),
    ),
  );

  locator.registerFactory(
        () => PopularMoviesBloc(
      locator(),
    ),
  );

  locator.registerFactory(
        () => TopRatedMoviesBloc(
      locator(),
    ),
  );

  locator.registerFactory(
        () => WatchlistMoviesBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );

  locator.registerFactory(
        () => MovieDetailBloc(
      locator(),
    ),
  );

  locator.registerFactory(
        () => TvDetailBloc(
      locator(),
    ),
  );

  locator.registerFactory(
        () => WatchlistTvBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );

  locator.registerFactory(
        () => OnAirTvBloc(
      locator(),
    ),
  );

  locator.registerFactory(
        () => TvRecommendationsBloc(
      locator(),
    ),
  );

  locator.registerFactory(
        () => PopularTvBloc(
      locator(),
    ),
  );


  locator.registerFactory(
        () => TopRatedTvBloc(
      locator(),
    ),
  );

  locator.registerFactory(
        () => SearchBloc(
      locator(),
    ),
  );

  locator.registerFactory(
        () => SearchBlocTv(
      locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetOnAirTv(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetPopularTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedTv(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTv(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTv(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  locator.registerLazySingleton(() => GetWatchlistTv(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  locator.registerLazySingleton<TvDatabaseHelper>(() => TvDatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => SSLPining.client);

}
