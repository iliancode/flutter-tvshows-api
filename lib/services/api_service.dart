import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/show.dart';

class ApiService {
  static const String baseUrl = 'https://www.episodate.com/api';

  static Future<List<Show>> fetchPopularShows(int page) async {
    final response = await http.get(Uri.parse('$baseUrl/most-popular?page=$page'));
    final List<dynamic> showsJson = json.decode(response.body)['tv_shows'];
    return showsJson.map((json) => Show.fromJson(json)).toList();
  }

  static Future<List<Show>> searchShows(String query, int page) async {
    final response = await http.get(Uri.parse('$baseUrl/search?q=$query&page=$page'));
    final List<dynamic> showsJson = json.decode(response.body)['tv_shows'];
    return showsJson.map((json) => Show.fromJson(json)).toList();
  }

  static Future<Show> fetchShowDetails(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/show-details?q=$id'));
    final jsonData = json.decode(response.body)['tvShow'];
    return Show.fromJson(jsonData);
  }
}
