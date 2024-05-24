import 'articles.dart';

class Data {
  Data({
    List<Articles>? articles,
  }) {
    _articles = articles;
  }

  Data.fromJson(dynamic json) {
    if (json['articles'] != null) {
      _articles = [];
      json['articles'].forEach((v) {
        _articles?.add(Articles.fromJson(v));
      });
    }
  }
  List<Articles>? _articles;

  List<Articles>? get articles => _articles;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_articles != null) {
      map['articles'] = _articles?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
