class CookiesResponse {
    final int age;
  final String restaurant;
  final int type;
  final String info;
  final int distance;

  CookiesResponse({
    required this.age,
    required this.restaurant,
    required this.type,
    required this.info,
    required this.distance,
  });
  factory CookiesResponse.fromJson(Map<String, dynamic> json) {
    return CookiesResponse(
      age: json['age'],
      restaurant: json['restarunat'], // 주의: 'restaurant' 필드 이름이 잘못되어 'restarunat'로 표기됨
      type: json['type'],
      info: json['info'],
      distance: json['distance'],
    );
  }
  String get cookieType {
    switch (type) {
      case 0:
        return 'white';
      case 1:
        return 'khu';
      default:
        return 'normal';

    
  }}
}
class MetadataResponse {
  final int per;
  final int total;
  final int page;

  MetadataResponse({
    required this.per,
    required this.total,
    required this.page,
  });
  factory MetadataResponse.fromJson(Map<String, dynamic> json) {
    return MetadataResponse(
      per: json['per'],
      total: json['total'],
      page: json['page'],
    );
  }
}
class GetCookiesResponse {
  final List<CookiesResponse> cookies;
  final MetadataResponse metadata;
  GetCookiesResponse({
    required this.cookies,
    required this.metadata,
  });
  factory GetCookiesResponse.fromJson(Map<String, dynamic> json) {
    var cookieList = json['items'] as List;
    List<CookiesResponse> cookies = cookieList.map((e) => CookiesResponse.fromJson(e)).toList();
    return GetCookiesResponse(
      cookies: cookies,
      metadata: MetadataResponse.fromJson(json['metadata']),
    );
  }
}