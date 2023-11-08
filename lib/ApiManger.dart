import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/popular/PoupularResponse.dart';
import 'package:movies_app/popular/Results.dart';

import 'Discover/DiscoverResponse.dart';
import 'Genere/GenereResponse.dart';
import 'NewReleses/UpComming.dart';
import 'Recommended/RecommendedResponse.dart';
import 'Search/SearchResponse.dart';

class ApiManager{

  final String _baseUrl = 'https://api.themoviedb.org/3/movie/popular?api_key=a89109ffba2e2994b3eaa076af591fda';

  Future<List<Results>> fetchPopularMovies() async {
    final response = await http.get(
    Uri.parse(_baseUrl),
    );
    if (response.statusCode == 200) {
      List<dynamic> results = jsonDecode(response.body)['results'];
      return results.map((movie) => Results.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<UpComming> fetchUpcomingMovies() async {
    final apiKey = 'a89109ffba2e2994b3eaa076af591fda';
    final url = 'https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return UpComming.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load upcoming movies');
    }
  }

  Future<RecommendedResponse> fetchRecommendMovies() async {
    final apiKey = 'a89109ffba2e2994b3eaa076af591fda';
    final url = 'https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return RecommendedResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load upcoming movies');
    }
  }

  Future<SearchResponse> searchMovie2(String query) async {
    final baseUrl ='https://api.themoviedb.org/3';
    final apiKey = 'a89109ffba2e2994b3eaa076af591fda';
    final url = Uri.parse('https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$query');
    final response = await http.get(url);
    if (response.statusCode == 200) {
     // return json.decode(response.body);
      return SearchResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load movie');
    }
  }
  Future<SearchResponse> searchMovie(String title) async {
    final baseUrl ='https://api.themoviedb.org/3';
    final apiKey = 'a89109ffba2e2994b3eaa076af591fda';

    final query = Uri.encodeComponent(title);
    final url ='https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$query';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // return json.decode(response.body);
      final data = json.decode(response.body);
      print(data);
      return SearchResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load movie');
    }
  }

  Future<GenereResponse> getGenres() async {
    final baseUrl ='https://api.themoviedb.org/3';
    final apiKey = 'a89109ffba2e2994b3eaa076af591fda';
    final response = await http.get(Uri.parse('$baseUrl/genre/movie/list?api_key=$apiKey'));
    if (response.statusCode == 200) {
      return GenereResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load genres');
    }
  }

  Future<DiscoverResponse> getMoviesByGenre(int genreId) async {
    final baseUrl ='https://api.themoviedb.org/3';
    final apiKey = 'a89109ffba2e2994b3eaa076af591fda';
    final response = await http.get(Uri.parse('$baseUrl/discover/movie?api_key=$apiKey&with_genres=$genreId'));
    if (response.statusCode == 200) {
      return DiscoverResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<Results>> fetchSimilarMovies(int movieId) async {
    final apiKey = 'a89109ffba2e2994b3eaa076af591fda';
    final String url = 'https://api.themoviedb.org/3/movie/$movieId/similar?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'];
      return results.map((result) => Results.fromJson(result)).toList();
    } else {
      throw Exception('Failed to load similar movies');
    }
  }



    }



