import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:your_app/data/sources/trip_data_source.dart';
import 'package:your_app/models/trip_model.dart';
import 'package:your_app/repositories/trip_repository.dart';

// Define the state for trips
class TripState {
  final bool isLoading;
  final List<TripModel> trips;
  final String? error;

  TripState({
    this.isLoading = false,
    this.trips = const [],
    this.error,
  });

  TripState copyWith({
    bool? isLoading,
    List<TripModel>? trips,
    String? error,
  }) {
    return TripState(
      isLoading: isLoading ?? this.isLoading,
      trips: trips ?? this.trips,
      error: error ?? this.error,
    );
  }
}

// StateNotifier for managing trip state
class TripNotifier extends StateNotifier<TripState> {
  final TripRepository _repository;

  TripNotifier(this._repository) : super(TripState());

  Future<void> fetchTrips() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final trips = await _repository.getTrips();
      state = state.copyWith(isLoading: false, trips: trips);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

// Providers
final tripDataSourceProvider = Provider<TripDataSource>((ref) {
  return TripDataSource(baseUrl: 'https://api.example.com');
});

final tripRepositoryProvider = Provider<TripRepository>((ref) {
  final dataSource = ref.watch(tripDataSourceProvider);
  return TripRepository(dataSource: dataSource);
});

final tripProvider = StateNotifierProvider<TripNotifier, TripState>((ref) {
  final repository = ref.watch(tripRepositoryProvider);
  return TripNotifier(repository);
});