
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/ApiManger.dart';
import 'package:movies_app/popular/PoupularResponse.dart';
import 'package:movies_app/popular/Results.dart';
import 'package:video_player/video_player.dart';

class DetailsMovie extends StatefulWidget{
  static const String routeName = 'detail';
  final Results movie;

  DetailsMovie({required this.movie});

  @override
  State<DetailsMovie> createState() => _DetailsMovieState();
}

class _DetailsMovieState extends State<DetailsMovie> {

  late Future<List<Results>> similarMovies;




  @override
  void initState() {
    super.initState();
    similarMovies = ApiManager().fetchSimilarMovies(widget.movie.id?? 0);


  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
       title:
       Text(widget.movie.title?? " ",style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold, color: Colors.white, )),
      backgroundColor: Colors.black,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
       ),
      backgroundColor: Theme.of(context).primaryColor,
      body:

      Column(
        children: [

          // 1. Show Image
         Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [
          Expanded(
            flex: 1,
            child: Image.network(
              'https://image.tmdb.org/t/p/w500${widget.movie.posterPath}',
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
            ),
          ),

         ]
        ),

          Text(widget.movie.title?? " ",style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold, color: Colors.white, )),

//******************** End CarouselSlider****************

          // 2. Movie details section

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Stack(
                  children: <Widget>[
                    Image.network(
                      'https://image.tmdb.org/t/p/w500${widget.movie.posterPath}',
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 0.0,
                      left: 0.0,
                      child:  Image.asset('assets/images/plus.png',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 8.0),
              Expanded(
                flex: 2,
                child: SingleChildScrollView(

                  padding: EdgeInsets.all(5.0),
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 6.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 3.0),
                        child: Text(
                          widget.movie.overview ?? "",
                          maxLines: 5, // Limit to 5 lines
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 30.0,
                          ),
                          SizedBox(width: 3.0),
                          Text(
                            widget.movie.voteCount?.toString() ?? '0',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.0),
          // 3. More like this section
          //**********************************************
          SingleChildScrollView(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[

    Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Text(
    'More Like This',
    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Colors.white),
    ),
    ),
    FutureBuilder<List<Results>>(
    future: similarMovies,
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
    return Center(child: Text('Error: ${snapshot.error}'));
    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
    return Center(child: Text('No similar movies found',style: TextStyle(color: Colors.white)));
    } else {

    return Container(
    height: 220,

      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          Results similarMovie = snapshot.data![index];
          return GestureDetector(
            onTap: () {
              // Your onTap functionality here
            },
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      color: Colors.grey,
                      width: 140,
                      child: Image.network(
                        'https://image.tmdb.org/t/p/w500${similarMovie.posterPath}',
                        width: double.infinity,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 0.0,
                      left: 0.0,
                      child:
                        Image.asset('assets/images/plus.png',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
          SizedBox(height: 8.0),
        Row(
    mainAxisSize: MainAxisSize.min, // Use min to avoid extra horizontal space
    children: [
          Icon(
            Icons.star, // Filled or outlined star
            color: Colors.yellow, // Star color
            size: 30.0, // Star size
          ),
          Text(
            similarMovie.voteCount?.toString() ?? '0',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),
          ),
]),
          Text(similarMovie.originalTitle?? "",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 16,color: Colors.white),
          ),

        ],
      ),
    );
    },
    ),
    );
    }
    },
    ),
    ],
          ),
          ),

        ],
      ),
    );
  }

}






