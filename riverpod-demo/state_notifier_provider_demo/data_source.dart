import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:your_app/models/trip_model.dart';

class TripDataSource {
  final String baseUrl;

  TripDataSource({required this.baseUrl});

  Future<List<TripModel>> fetchTrips() async {
    final response = await http.get(Uri.parse('$baseUrl/trips'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => TripModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load trips: ${response.statusCode}');
    }
  }
}