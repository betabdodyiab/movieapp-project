import 'ResultsSearch.dart';

/// page : 1
/// results : [{"adult":false,"backdrop_path":"/8RKBHHRqOMOLh5qW3sS6TSFTd8h.jpg","genre_ids":[28,878,12],"id":399579,"original_language":"en","original_title":"Alita: Battle Angel","overview":"When Alita awakens with no memory of who she is in a future world she does not recognize, she is taken in by Ido, a compassionate doctor who realizes that somewhere in this abandoned cyborg shell is the heart and soul of a young woman with an extraordinary past.","popularity":49.333,"poster_path":"/xRWht48C2V8XNfzvPehyClOvDni.jpg","release_date":"2019-01-31","title":"Alita: Battle Angel","video":false,"vote_average":7.221,"vote_count":8501},{"adult":false,"backdrop_path":null,"genre_ids":[99],"id":1083006,"original_language":"it","original_title":"Noi siamo Alitalia","overview":"The documentary focuses on the definitive closure of national airline Alitalia enlighten about the events and the political interference that caused the largest mass layoff ever in the history of Italy (11K workers).","popularity":0.666,"poster_path":"/gQoONcPZLEfhqBMg3i1d3x2SDdq.jpg","release_date":"2022-05-05","title":"We are Alitalia","video":false,"vote_average":0,"vote_count":0},{"adult":false,"backdrop_path":null,"genre_ids":[16],"id":727664,"original_language":"zh","original_title":"阿莉塔的试炼","overview":"The last dragon and the strongest knight are unable to destroy each other and decide to make a bet to determine the winner","popularity":0.6,"poster_path":"/bZ0ygTYi8xknaIusXtxOHgyB2OY.jpg","release_date":"2016-10-27","title":"Alita's Trial","video":false,"vote_average":0,"vote_count":0},{"adult":false,"backdrop_path":null,"genre_ids":[],"id":1177001,"original_language":"en","original_title":"Ang Alitaptap","overview":"A short film made for Venezia 70 - Future Reloaded.","popularity":1.346,"poster_path":"/e8q4ywbO8C0LnHLPFeuluwWsoE7.jpg","release_date":"2013-08-31","title":"The Firefly","video":false,"vote_average":0,"vote_count":0},{"adult":false,"backdrop_path":null,"genre_ids":[35],"id":504715,"original_language":"tl","original_title":"Facundo Alitaftaf","overview":"A homeless woman died giving birth to her twin sons. One of the twins, Alitaftaf is adopted by a poor couple while the other, Facundo, is adopted by a middle-class couple. The twins grew up with contrasting lifestyles, so they built different personalities. Alitaftaf has difficulty speaking but is good-hearted while Facundo is spoiled and naughty.","popularity":1.176,"poster_path":"/7e2ZqSnOqy5mrhxKtpxxUVtLo00.jpg","release_date":"1978-04-20","title":"Facundo Alitaftaf","video":false,"vote_average":0,"vote_count":0},{"adult":false,"backdrop_path":null,"genre_ids":[16],"id":815287,"original_language":"es","original_title":"Como Alitas de Chincol","overview":"An animated homage to the “arpilleras”, women that knitted history in Chile during the dictatorship.","popularity":1.341,"poster_path":"/zKJcRmZuY3s2XyPgXJmDe307y8U.jpg","release_date":"2002-01-07","title":"Like Wings of Little Birds","video":false,"vote_average":0,"vote_count":0},{"adult":false,"backdrop_path":null,"genre_ids":[878],"id":1118687,"original_language":"en","original_title":"Untitled Alita: Battle Angel Sequel","overview":"Rumored sequel to Alita: Battle Angel, with plans to incorporate new technologies and techniques.","popularity":0.842,"poster_path":null,"release_date":"","title":"Untitled Alita: Battle Angel Sequel","video":false,"vote_average":0,"vote_count":0},{"adult":false,"backdrop_path":"/hf1huOYmOGlahJqGHSLpy4VetGo.jpg","genre_ids":[16,28,878],"id":17189,"original_language":"ja","original_title":"銃夢","overview":"In his travels as a bounty hunter, Hunter–Warrior and cyborg healer Ido one day discovers and repairs the remnants of a cyborg whom he names Gally. Though possessing the body of a young woman, Gally now embodies Ido's most sophisticated and lethal cybernetic skills. The preternaturally strong, amnesiac Gally begins to forge a life for herself in a world where every day is a struggle for survival.","popularity":14.234,"poster_path":"/urvznwew7HrjrIEbK2RLaEkaezs.jpg","release_date":"1993-06-21","title":"Battle Angel","video":false,"vote_average":6.799,"vote_count":182},{"adult":false,"backdrop_path":"/lPhNSEDHv5kI0E3gINvxKeLwHyG.jpg","genre_ids":[35],"id":587429,"original_language":"es","original_title":"Dulce familia","overview":"A fat woman attempts to lose weight in order to use her mother's wedding dress with the help of  her evil sisters and needy fiancé.","popularity":8.43,"poster_path":"/3lyaM4QT30eh7ok0hBb13UtWoY.jpg","release_date":"2019-05-10","title":"Sweet Family","video":false,"vote_average":7.534,"vote_count":116},{"adult":false,"backdrop_path":null,"genre_ids":[99],"id":413835,"original_language":"ar","original_title":"خارج الإطار أو ثورة حتى النصر","overview":"A unique historical portrait of the Palestinian people's struggle to produce their own image. Using material long hidden in archives across the globe, the film reaches back through the modern history of Palestine and reverses decades of colonial dominance with a mosaic of struggle from the perspective of the colonized.","popularity":0.6,"poster_path":"/VRVEFfUmgZALJg5Pe2gNmrgQmW.jpg","release_date":"2016-09-10","title":"Off Frame AKA Revolution Until Victory","video":false,"vote_average":6.3,"vote_count":6}]
/// total_pages : 1
/// total_results : 10

class SearchResponse {
  SearchResponse({
      this.page, 
      this.results, 
      this.totalPages, 
      this.totalResults,});

  SearchResponse.fromJson(dynamic json) {
    page = json['page'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(ResultsSearch.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }
  int? page;
  List<ResultsSearch>? results;
  int? totalPages;
  int? totalResults;
SearchResponse copyWith({  int? page,
  List<ResultsSearch>? results,
  int? totalPages,
  int? totalResults,
}) => SearchResponse(  page: page ?? this.page,
  results: results ?? this.results,
  totalPages: totalPages ?? this.totalPages,
  totalResults: totalResults ?? this.totalResults,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = page;
    if (results != null) {
      map['results'] = results?.map((v) => v.toJson()).toList();
    }
    map['total_pages'] = totalPages;
    map['total_results'] = totalResults;
    return map;
  }

}