import 'package:csc13118_mobile/model/token.dart';

class TokensUser{
  TokenUser? access;
  TokenUser? refresh;

  TokensUser({
    this.access,
    this.refresh
  });

  TokensUser.fromJson(Map<String, dynamic> json) {
    access = TokenUser.fromJson(json['access']);
    refresh = TokenUser.fromJson(json['refresh']);
  }

  Map<String, dynamic> toJson() => {
    'access': access?.toJson(),
    'refresh': refresh?.toJson(),
  };

}