class SecondProfileRequest {
  String openId;
  String restaruant;
  String selfInfo;
  SecondProfileRequest(
      {required this.openId, required this.restaruant, required this.selfInfo});
  Map<String, dynamic> toJson() {
    return {
      'openId': openId,
      'restaruant': restaruant,
      'selfInfo': selfInfo,
    };
  }
}
