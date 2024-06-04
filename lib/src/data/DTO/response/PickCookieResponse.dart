class PartnerDetail {
  final String openID;
  final String selfInfo;

  PartnerDetail({
    required this.openID,
    required this.selfInfo,
  });

  factory PartnerDetail.fromJson(Map<String, dynamic> json) {
    return PartnerDetail(
      openID: json['openID'],
      selfInfo: json['selfInfo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'openID': openID,
      'selfInfo': selfInfo,
    };
  }
}

class PickCookieResponse {
  final PartnerDetail partnerDetail;

  PickCookieResponse({
    required this.partnerDetail,
  });

  factory PickCookieResponse.fromJson(Map<String, dynamic> json) {
    return PickCookieResponse(
      partnerDetail: PartnerDetail.fromJson(json['partnerDetail']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'partnerDetail': partnerDetail.toJson(),
    };
  }
}