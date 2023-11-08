
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchMovieDetails extends StatelessWidget {
  final Map movie;
  static const baseUrl = 'https://api.themoviedb.org/3';
 static const imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
  const SearchMovieDetails({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SearchMovieDetails = movie['results'][0];
    final imageUrl = imageBaseUrl + SearchMovieDetails['poster_path'];

    return Column(
      children: [
        Text(SearchMovieDetails['title'], style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color:Colors.white)),
        SizedBox(height: 10),
        Image.network(imageUrl),
        SizedBox(height: 10),
        Text(SearchMovieDetails['overview'], style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color:Colors.white)),
      ],
    );
  }
}