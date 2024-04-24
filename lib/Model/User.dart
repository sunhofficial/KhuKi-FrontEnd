// class User {
//   final 
// }

class LoginResponse {
  final String id;
  final String email;
  final String accessToken;

  LoginResponse({
    required this.id,
    required this.email,
    required this.accessToken,
  });

factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      id: json['user']['id'],
      email: json['user']['email'],
      accessToken: json['accessToken'],
    );
  }
}