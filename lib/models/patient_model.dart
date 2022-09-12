// ignore_for_file: non_constant_identifier_names

import 'package:intl/intl.dart';

List<PatientModel> patientFromJson(dynamic str) =>
    List<PatientModel>.from((str).map((x) => PatientModel.fromJson(x)));

class PatientModel {
  late int idP;
  late String nom;
  late String prenom;
  late String sexe;
  late DateTime date_naissance;

  PatientModel(
      {required this.idP,
      required this.nom,
      required this.prenom,
      required this.sexe,
      required this.date_naissance});

  PatientModel.fromJson(Map<String, dynamic> json) {
    idP = json['Id_P'];
    nom = json['nom'];
    prenom = json['prenom'];
    sexe = json['sexe'];
    date_naissance = DateTime.parse(json['date_naissance']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id_P'] = idP;
    data['nom'] = nom;
    data['prenom'] = prenom;
    data['sexe'] = sexe;
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    data['date_naissance'] = dateFormat.format(date_naissance);
    return data;
  }
}
