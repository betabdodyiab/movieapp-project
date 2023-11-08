
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/ApiManger.dart';

import 'Discover/DiscoverResponse.dart';
import 'Genere/GenereResponse.dart';
import 'Genere/Genres.dart';
import 'HomeScreen.dart';
import 'SearchScreen.dart';
import 'WatchList.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Browse extends StatefulWidget{
  static const String routeName = 'browse';

  @override
  State<Browse> createState() => _BrowseState();
}

class _BrowseState extends State<Browse> {
  int selectedTabIndex=2;
   final baseUrl ='https://api.themoviedb.org/3';
  final apiKey = 'a89109ffba2e2994b3eaa076af591fda';
  static String? _selectedGenreName='';
  late Future<GenereResponse> futureGenres;

  List<dynamic> _categories = [];
  List<dynamic> _movies = [];
  int? _selectedGenreId;
 // static String? _selectedGenreName;
  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    var url = Uri.parse('$baseUrl/genre/movie/list?api_key=$apiKey');
    var response = await http.get(url);
    var body = json.decode(response.body);
    setState(() {
      _categories = body['genres'];
    });
  }




  Future<void> _fetchMovies(int genreId) async {
    var url = Uri.parse('$baseUrl/discover/movie?api_key=$apiKey&with_genres=$genreId');
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
         var body = json.decode(response.body);
        setState(() {
          _movies = body['results'];
        });
      } else {
        throw Exception('Failed to load movies');
      }
    } on Exception catch (e) {
       print(e.toString());
       setState(() {
        _movies = [];
       });
    }
  }

  TextStyle dropdownTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );



  Widget _buildCategoryList() {
    TextStyle dropdownTextStyle = TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );
    return DropdownButton<int>(
        hint: Text(
          "Browse Category",
          style: dropdownTextStyle,textAlign: TextAlign.left,
        ),
        value: _selectedGenreId,
        style: dropdownTextStyle, // This ensures the selected item uses the style
        items: _categories.map((category) {
      return DropdownMenuItem<int>(
        value: category['id'],
        child: Text(
          category['name'],
          style: dropdownTextStyle,
        ),
      );
        }).toList(),

      onChanged: (value) {
        setState(() {
          _selectedGenreId = value;
          // Find the selected category name by the ID
          var selectedCategory = _categories.firstWhere(
                  (category) => category['id'] == value,
              orElse: () => {'name': 'No Category'});
          _selectedGenreName = selectedCategory['name'];
          _movies.clear();
        });
        _fetchMovies(value!);
      },



      dropdownColor: Colors.black, // Optional: to style the dropdown background color
    );
  }


  Widget _buildMovieGrid() {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: (3 / 2),
    ),
    itemCount: _movies.length,
    itemBuilder: (context, index) {
    var movie = _movies[index];
    String imageUrl = movie['poster_path'] != null
    ? 'https://image.tmdb.org/t/p/w500${movie['poster_path']}'
        : 'https://via.placeholder.com/150';
    return Card(
    clipBehavior: Clip.antiAlias,
    child: Stack(
    children: <Widget>[
    Image.network(
    imageUrl,
    width: double.infinity,
    height: double.infinity,
    fit: BoxFit.cover,
    ),
      Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: Text(
          _selectedGenreName!, // Use the selected category name here
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            backgroundColor: Colors.black45,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
    ),
    );
    },
    );
  }

  @override
  Widget build (BuildContext context){
    return Scaffold(
     backgroundColor: Theme.of(context).primaryColor,
      // color: Colors.white,
      appBar: AppBar(title: Text('MoviesApp') ,

        backgroundColor: Theme.of(context).primaryColor,),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          setState(() {
            selectedTabIndex=index;
            tabs[selectedTabIndex];
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => tabs[selectedTabIndex], // The new route's widget
              ),
            );
          });
        },
        currentIndex:selectedTabIndex ,
        items: [
          BottomNavigationBarItem(backgroundColor: Theme.of(context).primaryColor,icon: ImageIcon(AssetImage('assets/images/home.png')),label:'Home'),
          BottomNavigationBarItem(backgroundColor: Theme.of(context).primaryColor,icon: ImageIcon(AssetImage('assets/images/search.png')),label:'SEARCH'),
          BottomNavigationBarItem(backgroundColor: Theme.of(context).primaryColor,icon: ImageIcon(AssetImage('assets/images/browse.png')),label:'BROWSE'),
          BottomNavigationBarItem(backgroundColor: Theme.of(context).primaryColor,icon: ImageIcon(AssetImage('assets/images/watch.png')),label:'WATCHLIST')
        ],
      ),
      body:
      Column(
        children: <Widget>[
          _buildCategoryList(),
          Expanded(
            child: _selectedGenreId != null ? _buildMovieGrid() : Container(),
          ),
        ],
      ),
    );


}
  List<Widget>tabs=[
    HomeScreen(),
    SearchScreen(),
    Browse(),
    WatchList()
  ];
}