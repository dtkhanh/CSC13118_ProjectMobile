
class TokenUser {

  String? token;
  String? expires;

  TokenUser({
    this.token,
    this.expires,
  });

  TokenUser.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    expires = json['expires'];
  }

  Map<String, dynamic> toJson() => {
    'token': token,
    'expires': expires,
  };

}