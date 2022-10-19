part of 'search_bloc.dart';


abstract class SearchStateTv extends Equatable {
  const SearchStateTv();

  List<Object> get props => [];
}

class SearchEmpty extends SearchStateTv {}

class SearchLoading extends SearchStateTv {}

class SearchError extends SearchStateTv {
  final String message;

  SearchError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchHasData extends SearchStateTv {
  final List<Tv> result;

  SearchHasData(this.result);

  @override
  List<Object> get props => [result];
}