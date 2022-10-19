import 'package:equatable/equatable.dart';

class TvGenre extends Equatable {
  TvGenre({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  @override
  List<Object> get props => [id, name];
}
