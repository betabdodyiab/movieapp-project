
class MovieWatchList {
  static const String collectionName = 'WLists';

  String? id;
  String? originalTitle;
  String? posterPath;

  MovieWatchList({this.id, this.originalTitle, this.posterPath });

  MovieWatchList.fromFireStore(Map<String, dynamic>? data) :this (
    id: data?['id'],
    originalTitle: data?['originalTitle'],
    posterPath: data?['posterPath'],
  );


  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'originalTitle': originalTitle,
      'posterPath': posterPath,
    };
  }
}
