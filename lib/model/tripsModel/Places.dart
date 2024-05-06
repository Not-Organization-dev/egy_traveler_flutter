class Places {
  Places({
      String? name, 
      String? description, 
      String? startAt, 
      String? endAt, 
      String? id,}){
    _name = name;
    _description = description;
    _startAt = startAt;
    _endAt = endAt;
    _id = id;
}

  Places.fromJson(dynamic json) {
    _name = json['name'];
    _description = json['description'];
    _startAt = json['startAt'];
    _endAt = json['endAt'];
    _id = json['_id'];
  }
  String? _name;
  String? _description;
  String? _startAt;
  String? _endAt;
  String? _id;

  String? get name => _name;
  String? get description => _description;
  String? get startAt => _startAt;
  String? get endAt => _endAt;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['description'] = _description;
    map['startAt'] = _startAt;
    map['endAt'] = _endAt;
    map['_id'] = _id;
    return map;
  }

}