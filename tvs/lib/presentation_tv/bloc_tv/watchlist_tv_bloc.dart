import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import '../../domain_tv/entities_tv/tv.dart';
import '../../domain_tv/entities_tv/tv_detail.dart';
import '../../domain_tv/usecases_tv/get_watchlist_status_tv.dart';
import '../../domain_tv/usecases_tv/get_watchlist_tv.dart';
import '../../domain_tv/usecases_tv/remove_watchlist_tv.dart';
import '../../domain_tv/usecases_tv/save_watchlist_tv.dart';


part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTvBloc
    extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  final GetWatchlistTv _getWatchlistTv;
  final GetWatchListStatusTv _getWatchListStatusTv;
  final RemoveWatchlistTv _removeWatchlistTv;
  final SaveWatchlistTv _saveWatchlistTv;
  WatchlistTvBloc(
      this._getWatchlistTv,
      this._getWatchListStatusTv,
      this._removeWatchlistTv,
      this._saveWatchlistTv,
      ) : super(WatchlistTvEmpty()) {
    on<FetchWatchlistTv>((event, emit) async {
      emit(WatchlistTvLoading());
      final result = await _getWatchlistTv.execute();
      result.fold(
            (failure) => emit(WatchlistTvError(failure.message)),
            (data) => data.isNotEmpty
            ? emit(WatchlistTvHasData(data))
            : emit(WatchlistTvEmpty()),
      );
    });

    on<FetchWatchlistStatus>(((event, emit) async {
      final id = event.id;

      final result = await _getWatchListStatusTv.execute(id);

      emit(WatchlistTvIsAdded(result));
    }));

    on<AddTvToWatchlist>(
      ((event, emit) async {
        final movie = event.tv;

        final result = await _saveWatchlistTv.execute(movie);

        result.fold(
              (failure) => emit(WatchlistTvError(failure.message)),
              (message) => emit(
            WatchlistTvMessage(message),
          ),
        );
      }),
    );

    on<RemoveTvFromWatchlist>(
      ((event, emit) async {
        final tv = event.tv;

        final result = await _removeWatchlistTv.execute(tv);

        result.fold(
              (failure) => emit(WatchlistTvError(failure.message)),
              (message) => emit(
            WatchlistTvMessage(message),
          ),
        );
      }),
    );
  }
}
