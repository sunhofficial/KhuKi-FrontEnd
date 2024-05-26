class PostMyCookieRequest {
  final String info;
  final int type;
     PostMyCookieRequest({required this.info, required this.type});
    Map<String, dynamic> toJson() {
      return {
        'info': info,
        'type': type,};
      }
}