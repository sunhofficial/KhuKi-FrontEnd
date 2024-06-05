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
