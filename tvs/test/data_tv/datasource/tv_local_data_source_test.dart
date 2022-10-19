import 'package:movie/utils/exception.dart';
import 'package:tvs/data_tv/datasources/tv_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects_tv.dart';
import '../helpers_tv/test_helper_tv.mocks.dart';

void main() {
  late TvLocalDataSourceImpl dataSource;
  late MockTvDatabaseHelper mockTvDatabaseHelper;

  setUp(() {
    mockTvDatabaseHelper = MockTvDatabaseHelper();
    dataSource = TvLocalDataSourceImpl(databaseHelper: mockTvDatabaseHelper);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
            () async {
          // arrange
          when(mockTvDatabaseHelper.insertWatchlistTv(testTvTable))
              .thenAnswer((_) async => 1);
          // act
          final result = await dataSource.insertWatchlistTv(testTvTable);
          // assert
          expect(result, 'Added to Watchlist');
        });

    test('should throw DatabaseException when insert to database is failed',
            () async {
          // arrange
          when(mockTvDatabaseHelper.insertWatchlistTv(testTvTable))
              .thenThrow(Exception());
          // act
          final call = dataSource.insertWatchlistTv(testTvTable);
          // assert
          expect(() => call, throwsA(isA<DatabaseException>()));
        });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
            () async {
          // arrange
          when(mockTvDatabaseHelper.removeWatchlistTv(testTvTable))
              .thenAnswer((_) async => 1);
          // act
          final result = await dataSource.removeWatchlistTv(testTvTable);
          // assert
          expect(result, 'Removed from Watchlist');
        });

    test('should throw DatabaseException when remove from database is failed',
            () async {
          // arrange
          when(mockTvDatabaseHelper.removeWatchlistTv(testTvTable))
              .thenThrow(Exception());
          // act
          final call = dataSource.removeWatchlistTv(testTvTable);
          // assert
          expect(() => call, throwsA(isA<DatabaseException>()));
        });
  });

  group('Get Tv Detail By Id', () {
    final tId = 1;

    test('should return Tv Detail Table when data is found', () async {
      // arrange
      when(mockTvDatabaseHelper.getTvById(tId))
          .thenAnswer((_) async => testTvMap);
      // act
      final result = await dataSource.getTvById(tId);
      // assert
      expect(result, testTvTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockTvDatabaseHelper.getTvById(tId)).thenAnswer((_) async => null);
      // act
      final result = await dataSource.getTvById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist tv', () {
    test('should return list of TvTable from database', () async {
      // arrange
      when(mockTvDatabaseHelper.getWatchlistTv())
          .thenAnswer((_) async => [testTvMap]);
      // act
      final result = await dataSource.getWatchlistTv();
      // assert
      expect(result, [testTvTable]);
    });
  });
}
