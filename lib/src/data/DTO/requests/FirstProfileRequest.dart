  class FirstProfileRequest {
    String gender;
    int age;
    int distance;
    FirstProfileRequest({required this.gender, required this.age, required this.distance});
    Map<String, dynamic> toJson() {
      return {
        'gender': gender,
        'age': age,
        'distance': distance, };

      }
  }
class SecondProfileRequest {
  String openId;
  String restaruant;
  String selfInfo;
  SecondProfileRequest({required this.openId, required this.restaruant, required this.selfInfo});
  Map<String, dynamic> toJson() {
    return {
      'openId': openId,
      'restaruant': restaruant,
      'selfInfo': selfInfo, };

  }
}