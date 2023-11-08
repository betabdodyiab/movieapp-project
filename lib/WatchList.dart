import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/popular/Results.dart';

import 'ApiManger.dart';
import 'Browse.dart';
import 'HomeScreen.dart';
import 'SearchScreen.dart';

class WatchList extends StatefulWidget{
  static const String routeName = 'watch';

  @override
  State<WatchList> createState() => _WatchListState();
}

class _WatchListState extends State<WatchList> {
  int selectedTabIndex=3;
  late Future<List<Results>> Movies;
  @override
  void initState() {
    super.initState();
    Movies = ApiManager().fetchPopularMovies();   // Example search term
  }



  @override
  Widget build (BuildContext context){
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      // color: Colors.red,
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
      body:  FutureBuilder<List<Results>>(
        future: Movies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No movies found.'));
          } else {
            // We have data to display
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Results movie = snapshot.data![index];
                return ListTile(
                  leading: Container(
                    height: 200.0,
                    width: 180.0,
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text('${movie.originalTitle}  \n ${movie.releaseDate?.split('-')[0] }',style: TextStyle(color:Colors.white),),
                  trailing: IconButton(
                    icon: Icon(Icons.add, size: 40.0,color: Colors.white,),
                    onPressed: () {

                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }


  /*void addMovieToFirestore(Results movie) {
    // Assuming you have a method to add a movie to Firestore
    // It would look something like this:
    FirebaseFirestore.instance.collection('watchlist').doc(movie.id?? "").set({
      'title': movie.title,
      'posterPath': movie.posterPath,
      'year': movie.releaseDate,
      // 'actors': movie.actors,
    });
  }*/
}

  List<Widget>tabs=[
    HomeScreen(),
    SearchScreen(),
    Browse(),
    WatchList()
  ];
