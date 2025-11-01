import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data_models/bikes_model.dart';

/// Fetches a list of bike networks from CityBikes API.
Future<List<Network>> fetchBikes() async {
  final uri = Uri.parse('http://api.citybik.es/v2/networks');
  final resp = await http.get(uri);

  if (resp.statusCode != 200) {
    throw Exception('Bike API error: ${resp.statusCode}');
  }

  final data = bikesResponseFromJson(resp.body);
  return data.networks;
}
