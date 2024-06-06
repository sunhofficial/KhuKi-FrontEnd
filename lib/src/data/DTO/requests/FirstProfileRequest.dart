class FirstProfileRequest {
  String gender;
  int age;
  int distance;
  FirstProfileRequest(
      {required this.gender, required this.age, required this.distance});
  Map<String, dynamic> toJson() {
    return {
      'gender': gender,
      'age': age,
      'distance': distance,
    };
  }
}
