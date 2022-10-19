import 'package:tvs/data_tv/models/tv_table.dart';
import 'package:tvs/domain_tv/entities_tv/genre.dart';
import 'package:tvs/domain_tv/entities_tv/tv.dart';
import 'package:tvs/domain_tv/entities_tv/tv_detail.dart';

final testTv = Tv(
  backdropPath: '/3N3bUR0M9x3W5745KBFhXHawJrl.jpg',
  genreIds: [18],
  id: 1,
  originalName: 'プライド',
  overview:
  'The theme is strength and gallantry.Haru Satonaka is the captain of an ice-hockey team, a star athlete who stakes everything on hockey but can only consider love as a game. Aki Murase is a woman who has been waiting for her lover who went abroad two years ago. These two persons start a relationship while frankly admitting to each other that it is only a love game. …The result is the unfolding of a drama of people with their respective pasts and with their pride as individuals.',
  popularity: 4.857,
  posterPath: '/9Ub2BwnLYKoiSaQF93ItyXriCon.jpg',
  firstAirDate: '2004-01-12',
  name: 'Pride',
  voteAverage: 8.136,
  voteCount: 11,
);

final testTvList = [testTv];

final testTvDetail = TvDetail(
  backdropPath: 'backdropPath',
  genres: [TvGenre(id: 1, name: 'Action')],
  id: 1,
  originalName: 'originalName',
  overview: 'overview',
  posterPath: 'posterPath',
  firstAirDate: 'firstAirDate',
  name: 'name',
  voteAverage: 1,
  voteCount: 1,
  numberOfEpisodes: 11,
  numberOfSeasons: 1,
);

final testWatchlistTv = Tv.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvTable = TvTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};
