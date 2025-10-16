import 'package:your_app/data/sources/trip_data_source.dart';
import 'package:your_app/models/trip_model.dart';

class TripRepository {
  final TripDataSource _dataSource;

  TripRepository({required TripDataSource dataSource}) : _dataSource = dataSource;

  Future<List<TripModel>> getTrips() async {
    try {
      return await _dataSource.fetchTrips();
    } catch (e) {
      throw Exception('Repository error: $e');
    }
  }
}