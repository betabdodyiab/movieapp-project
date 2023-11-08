
import 'model/MovieWatchList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'model/MovieWatchList.dart';
class MovieWatchListDao {


 static CollectionReference<MovieWatchList> getMovCollection() {
    var db = FirebaseFirestore.instance;

    var movieCollection = db.collection(MovieWatchList.collectionName)
    .withConverter(
        fromFirestore: (snapshot,option) =>MovieWatchList.fromFireStore(snapshot.data()),
        toFirestore: (object,option)=>object.toFireStore()
    );
   return movieCollection;
  }

 static Future<void> createwatchLis(MovieWatchList movie){
   var movCollection=getMovCollection();
   var doc= movCollection.doc(movie.id);
return doc.set(movie);
  }
}



