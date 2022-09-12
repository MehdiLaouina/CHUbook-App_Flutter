class RegisterRequestModel {
  RegisterRequestModel({
    required this.nom,
    required this.password,
    required this.email,
    required this.prenom,
  });
  late final String nom;
  late final String password;
  late final String email;
  late final String prenom;

  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    nom = json['nom'];
    password = json['password'];
    email = json['email'];
    prenom = json['prenom'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['nom'] = nom;
    _data['password'] = password;
    _data['email'] = email;
    _data['prenom'] = prenom;
    return _data;
  }
}
