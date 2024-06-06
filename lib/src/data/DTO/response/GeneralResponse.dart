class GeneralResponse<T> {
  final int status;
  final String message;
  final T? data;

  GeneralResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory GeneralResponse.fromJson(
      Map<String, dynamic> json, T Function(Object? json)? fromJsonT) {
    return GeneralResponse<T>(
      status: json['status'],
      message: json['message'],
      data: fromJsonT != null && json.containsKey('data')
          ? fromJsonT(json['data'])
          : null,
    );
  }
}
