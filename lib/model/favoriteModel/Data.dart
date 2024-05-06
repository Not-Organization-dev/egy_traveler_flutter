import 'FavoritePlaces.dart';
import 'FavoriteArticles.dart';
import 'UserTrips.dart';

class Data {
  Data({
      List<FavoritePlaces>? favoritePlaces, 
      List<FavoriteArticles>? favoriteArticles, 
      List<UserTrips>? userTrips,}){
    _favoritePlaces = favoritePlaces;
    _favoriteArticles = favoriteArticles;
    _userTrips = userTrips;
}

  Data.fromJson(dynamic json) {
    if (json['favoritePlaces'] != null) {
      _favoritePlaces = [];
      json['favoritePlaces'].forEach((v) {
        _favoritePlaces?.add(FavoritePlaces.fromJson(v));
      });
    }
    if (json['favoriteArticles'] != null) {
      _favoriteArticles = [];
      json['favoriteArticles'].forEach((v) {
        _favoriteArticles?.add(FavoriteArticles.fromJson(v));
      });
    }
    if (json['userTrips'] != null) {
      _userTrips = [];
      json['userTrips'].forEach((v) {
        _userTrips?.add(UserTrips.fromJson(v));
      });
    }
  }
  List<FavoritePlaces>? _favoritePlaces;
  List<FavoriteArticles>? _favoriteArticles;
  List<UserTrips>? _userTrips;

  List<FavoritePlaces>? get favoritePlaces => _favoritePlaces;
  List<FavoriteArticles>? get favoriteArticles => _favoriteArticles;
  List<UserTrips>? get userTrips => _userTrips;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_favoritePlaces != null) {
      map['favoritePlaces'] = _favoritePlaces?.map((v) => v.toJson()).toList();
    }
    if (_favoriteArticles != null) {
      map['favoriteArticles'] = _favoriteArticles?.map((v) => v.toJson()).toList();
    }
    if (_userTrips != null) {
      map['userTrips'] = _userTrips?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}