import 'package:bloc_test/bloc_test.dart';
import 'package:movie/utils/failure.dart';
import 'package:search/domain/usecases/search_tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/presentation/tvs_bloc/search_bloc.dart';
import 'package:tvs/domain_tv/entities_tv/tv.dart';
import 'search_bloc.test.mocks.dart';


@GenerateMocks([SearchTv])
void main() {
  late SearchBlocTv searchBloc;
  late MockSearchTv mockSearchTv;

  setUp(() {
    mockSearchTv = MockSearchTv();
    searchBloc = SearchBlocTv(mockSearchTv);
  });

  test('initial state should be empty', () {
    expect(searchBloc.state, SearchEmpty());
  });

  final tTvModel = Tv(
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
  final tTvList = <Tv>[tTvModel];
  final tQuery = 'spiderman';

  blocTest<SearchBlocTv, SearchStateTv>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTv.execute(tQuery))
          .thenAnswer((_) async => Right(tTvList));
      return searchBloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      SearchHasData(tTvList),
    ],
    verify: (bloc) {
      verify(mockSearchTv.execute(tQuery));
    },
  );

  blocTest<SearchBlocTv, SearchStateTv>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchTv.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return searchBloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      SearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTv.execute(tQuery));
    },
  );
}
