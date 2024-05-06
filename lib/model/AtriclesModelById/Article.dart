class Article {
  Article({
      String? id, 
      String? title, 
      String? image, 
      String? hint, 
      String? when, 
      List<String>? decription, 
      num? v, 
      bool? isFavorite,}){
    _id = id;
    _title = title;
    _image = image;
    _hint = hint;
    _when = when;
    _decription = decription;
    _v = v;
    _isFavorite = isFavorite;
}

  Article.fromJson(dynamic json) {
    _id = json['_id'];
    _title = json['title'];
    _image = json['image'] ?? 'https://static.vecteezy.com/system/resources/previews/004/141/669/original/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg';
    _hint = json['hint'];
    _when = json['when'];
    _decription = json['decription'] != null ? json['decription'].cast<String>() : [];
    _v = json['__v'];
    _isFavorite = json['isFavorite'];
  }
  String? _id;
  String? _title;
  String? _image;
  String? _hint;
  String? _when;
  List<String>? _decription;
  num? _v;
  bool? _isFavorite;

  String? get id => _id;
  String? get title => _title;
  String? get image => _image;
  String? get hint => _hint;
  String? get when => _when;
  List<String>? get decription => _decription;
  num? get v => _v;
  bool? get isFavorite => _isFavorite;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['title'] = _title;
    map['image'] = _image;
    map['hint'] = _hint;
    map['when'] = _when;
    map['decription'] = _decription;
    map['__v'] = _v;
    map['isFavorite'] = _isFavorite;
    return map;
  }

}