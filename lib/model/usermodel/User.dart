class User {
  User({
      String? id, 
      String? name, 
      String? email,
      String? phone,
      String? address, 
      String? role, 
      bool? isVerified, 
      // List<dynamic>? preferences,
      String? avatar,
      String? createdAt, 
      num? v,}){
    _id = id;
    _name = name;
    _email = email;
    _address = address;
    _role = role;
    _phone = phone;
    _isVerified = isVerified;
    // _preferences = preferences;
    _avatar = avatar;
    _createdAt = createdAt;
    _v = v;
}

  User.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _phone = json['phone'];
    _email = json['email'];
    _address = json['address'];
    _role = json['role'];
    _isVerified = json['isVerified'];
/*    if (json['preferences'] != null) {
      _preferences = [];
      json['preferences'].forEach((v) {
        _preferences?.add(Dynamic.fromJson(v));
      });
    }*/
    _avatar = json['avatar'];
    _createdAt = json['createdAt'];
    _v = json['__v'];
  }
  String? _id;
  String? _name;
  String? _email;
  String? _address;
  String? _phone;
  String? _role;
  bool? _isVerified;
  List<dynamic>? _preferences;
  String? _avatar;
  String? _createdAt;
  num? _v;

  String? get id => _id;
  String? get name => _name;
  String? get phone => _phone;
  String? get email => _email;
  String? get address => _address;
  String? get role => _role;
  bool? get isVerified => _isVerified;
  List<dynamic>? get preferences => _preferences;
  String? get avatar => _avatar;
  String? get createdAt => _createdAt;
  num? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    map['address'] = _address;
    map['phone'] = _phone;
    map['role'] = _role;
    map['isVerified'] = _isVerified;
    if (_preferences != null) {
      map['preferences'] = _preferences?.map((v) => v.toJson()).toList();
    }
    map['avatar'] = _avatar;
    map['createdAt'] = _createdAt;
    map['__v'] = _v;
    return map;
  }

}