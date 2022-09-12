import 'dart:convert';

RegisterResponseModel registerResponseModel(String str) =>
    RegisterResponseModel.fromJson(json.decode(str));

class RegisterResponseModel {
  RegisterResponseModel({
    required this.message,
    required this.data,
  });
  late final String message;
  late final Data? data;

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['data'] = data!.toJson();
    return _data;
  }
}

class Data {
  Data(
      {required this.nom,
      required this.email,
      required this.prenom,
      required this.token,
      required this.id});
  late final String nom;
  late final String prenom;
  late final String email;
  late final String token;
  late final int id;

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
