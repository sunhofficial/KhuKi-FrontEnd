class Cookie {
  final String info;
  final int age;
  final int distance;
  final String restaurant;
  final int type;
  final String selfInfo;
  final String openID;

  Cookie({
    required this.info,
    required this.age,
    required this.distance,
    required this.restaurant,
    required this.type,
    required this.selfInfo,
    required this.openID,
  });
  String get cookieType {
    switch (type) {
      case 0:
        return 'white';
      case 1:
        return 'khu';
      default:
        return 'normal';
    }
  }
}
