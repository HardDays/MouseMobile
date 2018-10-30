class GenresFilter {
  List <String> genres;

  GenresFilter({this.genres = const []});

  bool get isNotEmpty => genres.isNotEmpty;
  
  Map <String, dynamic> toJson(){
    Map <String, dynamic> res = {};

    if (isNotEmpty){
      res['genres'] = genres;
    }
    
    return res;
  }
}