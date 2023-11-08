
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ApiManger.dart';
import 'Browse.dart';
import 'HomeScreen.dart';
import 'Search/SearchResponse.dart';

import 'WatchList.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchScreen extends StatefulWidget{
  static const String routeName = 'search';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

  class _SearchScreenState extends State<SearchScreen> {

  int selectedTabIndex=1;
    TextEditingController _controller = TextEditingController();
    Future<SearchResponse>? _searchResponse;

  static const apiKey = 'a89109ffba2e2994b3eaa076af591fda';
  static const baseUrl = 'https://api.themoviedb.org/3';
  static const imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  void _handleSearch() async {
    setState(() {
      _searchResponse = ApiManager().searchMovie(_controller.text);
    });
  }



  @override
  Widget build (BuildContext context){
    return Scaffold(
     backgroundColor: Theme.of(context).primaryColor,

      appBar: AppBar(title:Center(child: Text('MoviesApp')) ,
        backgroundColor: Theme.of(context).primaryColor,),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          setState(() {
            selectedTabIndex=index;
            tabs[selectedTabIndex];
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => tabs[selectedTabIndex],
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
          children: [
      Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          //labelText: 'Enter movie name',

          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            borderSide: BorderSide(
              color: Colors.white,
              width: 10.0,),),
              prefixIcon: IconButton(
            icon: Icon(Icons.search),
            onPressed: _handleSearch,
          ),
        ),
        style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),
      ),
    ),
    Expanded(
    child: FutureBuilder<SearchResponse>(
    future: _searchResponse,
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
    return Center(child: Text('Error: ${snapshot.error}'));
    } else if (snapshot.hasData) {

    return ListView.builder(
    itemCount: snapshot.data?.results?.length ?? 0,
    itemBuilder: (context, index) {
    final movie = snapshot.data!.results![index];

    return ListTile(
    title: Text(movie.title ?? 'No title',style: TextStyle(color:Colors.white),),
    //subtitle: Text(movie.overview ?? 'No description'),
      subtitle: Text(movie.popularity  != null ? movie.popularity!.toStringAsFixed(1) : '0.0',style: TextStyle(color:Colors.white)),

      leading: movie.posterPath != null
        ? SizedBox(
      width: 180.0,
      //width: 300.0,

      child: Image.network('$imageBaseUrl${movie.posterPath}', fit: BoxFit.cover,),
    )
        : null,
    );
    },
    );


    } else {
    return Center(child: Text('No results found',style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),)
    );
    }
    },
    ),
    ),
    ],
      ),);
    }
  }

  List<Widget>tabs=[
    HomeScreen(),
    SearchScreen(),
    Browse(),
    WatchList()
  ];
