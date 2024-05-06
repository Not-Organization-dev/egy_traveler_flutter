import 'Recommendations.dart';
import 'dart:convert';

RecommendModel recommendModelFromJson(String str) => RecommendModel.fromJson(json.decode(str));
String recommendModelToJson(RecommendModel data) => json.encode(data.toJson());
class RecommendModel {
  RecommendModel({
      this.recommendations,});

  RecommendModel.fromJson(dynamic json) {
    if (json['recommendations'] != null) {
      recommendations = [];
      json['recommendations'].forEach((v) {
        recommendations?.add(Recommendations.fromJson(v));
      });
    }
  }
  List<Recommendations>? recommendations;
RecommendModel copyWith({  List<Recommendations>? recommendations,
}) => RecommendModel(  recommendations: recommendations ?? this.recommendations,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (recommendations != null) {
      map['recommendations'] = recommendations?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}