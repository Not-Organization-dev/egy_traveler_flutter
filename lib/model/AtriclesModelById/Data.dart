import 'Article.dart';

class Data {
  Data({
      Article? article,}){
    _article = article;
}

  Data.fromJson(dynamic json) {
    _article = json['article'] != null ? Article.fromJson(json['article']) : null;
  }
  Article? _article;

  Article? get article => _article;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_article != null) {
      map['article'] = _article?.toJson();
    }
    return map;
  }

}