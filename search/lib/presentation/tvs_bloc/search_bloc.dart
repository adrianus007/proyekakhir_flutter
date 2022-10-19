import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvs/domain_tv/entities_tv/tv.dart';
import '../../domain/usecases/search_tv.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBlocTv extends Bloc<SearchEventTv, SearchStateTv> {
  final SearchTv _searchTv;

  SearchBlocTv(this._searchTv) : super(SearchEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchLoading());
      final result = await _searchTv.execute(query);

      result.fold(
            (failure) {
          emit(SearchError(failure.message));
        },
            (data) {
          emit(SearchHasData(data));
        },
      );
    });
  }
}
