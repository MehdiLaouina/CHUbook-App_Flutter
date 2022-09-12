import 'dart:convert';

LoginResponseModel loginResponseJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  LoginResponseModel({
    required this.message,
    required this.data,
  });
  late final String message;
  late final Data data;

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.nom,
    required this.email,
    required this.prenom,
    required this.id,
    required this.token,
  });
  late final String nom;
  late final String email;
  late final String prenom;
  late final int id;
  late final String token;

  Data.fromJson(Map<String, dynamic> json) {
    nom = json['nom'];
    email = json['email'];
    prenom = json['prenom'];
    id = json['id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['nom'] = nom;
    _data['email'] = email;
    _data['prenom'] = prenom;
    _data['id'] = id;
    _data['token'] = token;
    return _data;
  }
}
