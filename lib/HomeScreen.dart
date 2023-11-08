

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/ApiManger.dart';
import 'package:movies_app/Recommended/RecommendedResponse.dart';
import 'package:movies_app/SearchScreen.dart';
import 'package:movies_app/popular/Results.dart';
import 'Browse.dart';
import 'DetailsMovie.dart';
import 'NewReleses/ResultsUpComming.dart';
import 'NewReleses/UpComming.dart';
import 'Recommended/ResultsRecommend.dart';
import 'WatchList.dart';

class HomeScreen extends StatefulWidget{
static const String routeName = 'home';

ResultsUpComming? result;

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
int selectedTabIndex=0;
late Future<UpComming> _upcomingMovies;
late Future<RecommendedResponse> _recommendMovies;

final ApiManager _movieService = ApiManager();
List<Results> _movies = [];
bool _isLoading = true;

@override
void initState() {
  super.initState();
  _loadMovies();
  _upcomingMovies = ApiManager().fetchUpcomingMovies();
  _recommendMovies = ApiManager().fetchRecommendMovies();
}

void _loadMovies() async {
  try {
    _movies = await _movieService.fetchPopularMovies();
  } catch (e) {
    // handle the exception, perhaps show an error message
  }
  setState(() => _isLoading = false);
}


    @override
    Widget build(BuildContext context) {
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
      Container(
      child: Column(
      children: [
        //********************CarouselSlider****************************
    CarouselSlider(
      options: CarouselOptions(
      autoPlay: true,
      aspectRatio: 1.0,
      enlargeCenterPage: true,
      ),
      items: _movies.map((movie) {
      return Builder(
      builder: (BuildContext context) {
        return GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
               builder: (context) => DetailsMovie(movie: movie),

         // builder: (context) => DetailsMovie(),
            )),
      child: Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      child: Image.network('https://image.tmdb.org/t/p/w500${movie.posterPath}',
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
      return Center(
        child: CircularProgressIndicator(
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
              : null,
        ),

      );},
      ),
      ),
      ),);
      },
      );
      }).toList(),



        ),
        //******************** End CarouselSlider****************


        SizedBox(height: 10),

        //************************New Release ********************
       Text('New Releses',textAlign: TextAlign.left,style: TextStyle(color: Colors.white,fontSize: 28),),
        // Expanded(
        //   child: FutureBuilder<UpComming>(
        //     future: _upcomingMovies,
        //     builder: (context, snapshot) {
        //       if (snapshot.connectionState == ConnectionState.waiting) {
        //         return CircularProgressIndicator();
        //       } else if (snapshot.hasError) {
        //         return Text('Error: ${snapshot.error}');
        //       } else if (!snapshot.hasData  ) {
        //         return Text('No upcoming movies found.');
        //       }
        //
        //     //  List<ResultsUpComming> movies = snapshot?.data?.results??;
        //       List<ResultsUpComming> movies = snapshot.data?.results ?? <ResultsUpComming>[];
        //
        //       return ListView.builder(
        //         scrollDirection: Axis.horizontal,
        //         itemCount: movies.length,
        //         itemBuilder: (context, index) {
        //           return Padding(
        //             padding: const EdgeInsets.all(8.0),
        //             child: ClipRRect(
        //               borderRadius: BorderRadius.circular(10.0), // optional, for rounded corners
        //               child: Image.network(
        //                 'https://image.tmdb.org/t/p/w500${movies[index].posterPath}',
        //                 fit: BoxFit.cover,
        //               ),
        //             ),
        //           );
        //         },
        //       );
        //     },
        //   ),
        // ),


            Expanded(
              child: FutureBuilder<UpComming>(
                future: _upcomingMovies,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData) {
                    return Text('No upcoming movies found.');
                  }

                  List<ResultsUpComming> movies = snapshot.data?.results ?? <ResultsUpComming>[];

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      // Here we determine which image to show based on whether the index is odd or even
                      String smallImageUrl = index.isOdd
                          ? 'assets/images/plus.png'
                          : 'assets/images/check.png';

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          alignment: Alignment.topLeft,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(

                                'https://image.tmdb.org/t/p/w500${movies[index].posterPath}',
                                fit: BoxFit.cover,width: 100.0,
                              ),
                            ),
                            Positioned(
                              left: 0,
                              top: 0,
                              child:  Image.asset(
                                smallImageUrl,
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
             ),


        // ************************ End New Release ***************************

       SizedBox(height: 10),
        Text('Recomended', textAlign: TextAlign.start,style: TextStyle(color: Colors.white,fontSize: 28,),),
        //************************Recomended ********************
        // Expanded(
        //   child: FutureBuilder<RecommendedResponse>(
        //     future: _recommendMovies,
        //     builder: (context, snapshot) {
        //       if (snapshot.connectionState == ConnectionState.waiting) {
        //         return CircularProgressIndicator();
        //       } else if (snapshot.hasError) {
        //         return Text('Error: ${snapshot.error}');
        //       } else if (!snapshot.hasData  ) {
        //         return Text('No upcoming movies found.');
        //       }
        //
        //       //  List<ResultsUpComming> movies = snapshot?.data?.results??;
        //       List<ResultsRecommend> movies = snapshot.data?.results ?? <ResultsRecommend>[];
        //
        //       return ListView.builder(
        //         scrollDirection: Axis.horizontal,
        //         itemCount: movies.length,
        //         itemBuilder: (context, index) {
        //           return Padding(
        //             padding: const EdgeInsets.all(8.0),
        //             child: ClipRRect(
        //               borderRadius: BorderRadius.circular(10.0), // optional, for rounded corners
        //               child: Image.network(
        //                 'https://image.tmdb.org/t/p/w500${movies[index].posterPath}',
        //                 fit: BoxFit.cover,
        //               ),
        //             ),
        //           );
        //         },
        //       );
        //     },
        //   ),
        //   // ************************ End Recomended ***************************
        // ),

            Expanded(
              child: FutureBuilder<RecommendedResponse>(
                future: _recommendMovies,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData) {
                    return Text('No recommended movies found.');
                  }

                  List<ResultsRecommend> movies = snapshot.data?.results ?? <ResultsRecommend>[];

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          alignment: Alignment.topLeft,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                'https://image.tmdb.org/t/p/w500${movies[index].posterPath}',
                                fit: BoxFit.cover,width: 100.0,
                              ),
                            ),
                             Positioned(
                              left: 0.0,
                              top: 0.0,
                              child:  Image.asset(
                                'assets/images/plus.png',
                                width: 50,
                                height: 50,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            )
            //tabs[selectedTabIndex],
      ]),

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












