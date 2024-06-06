import "package:khukiting/src/domain/Model/Cookie.dart";

class PickedCookieDetail {
  final int age;
  final String selfInfo;
  final String restaurant;
  final String openId;
  final int type;
  final String info;
  final int distance;

  PickedCookieDetail({
    required this.age,
    required this.selfInfo,
    required this.restaurant,
    required this.openId,
    required this.type,
    required this.info,
    required this.distance,
  });

  factory PickedCookieDetail.fromJson(Map<String, dynamic> json) {
    return PickedCookieDetail(
      age: json['age'],
      selfInfo: json['selfInfo'],
      restaurant: json['restarunat'],
      openId: json['openId'],
      type: json['type'],
      info: json['info'],
      distance: json['distance'],
    );
  }
  Cookie toCookie() {
    return Cookie(
      info: info,
      age: age,
      distance: distance,
      restaurant: restaurant,
      type: type,
      selfInfo: selfInfo,
      openID: openId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'age': age,
      'selfInfo': selfInfo,
      'restarunat': restaurant,
      'openId': openId,
      'type': type,
      'info': info,
      'distance': distance,
    };
  }
}
