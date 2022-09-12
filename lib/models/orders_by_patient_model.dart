// ignore_for_file: non_constant_Identifier_names
import 'package:intl/intl.dart';

List<OrderByPatientModel> ordersPFromJson(dynamic str) =>
    List<OrderByPatientModel>.from(
        (str).map((x) => OrderByPatientModel.fromJson(x)));

class OrderByPatientModel {
  late int id;
  late int idHosix;
  late String designation;
  late String prescripteur;
  late DateTime date;
  late String etat;
  late int idP;
  late int idS;
  late String nom;
  late String prenom;
  late String sexe;
  late DateTime date_naissance;

  OrderByPatientModel(
      {required this.id,
      required this.idHosix,
      required this.designation,
      required this.prescripteur,
      required this.date,
      required this.etat,
      required this.idP,
      required this.idS,
      required this.nom,
      required this.prenom,
      required this.date_naissance,
      required this.sexe});

  OrderByPatientModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    idHosix = json['Id_Hosix'];
    designation = json['designation'];
    prescripteur = json['prescripteur'];
    date = DateTime.parse(json['date']);
    etat = json['etat'];
    idP = json['Id_P'];
    idS = json['Id_S'];
    nom = json['nom'];
    prenom = json['prenom'];
    date_naissance = DateTime.parse(json['date_naissance']);
    sexe = json['sexe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = id;
    data['Id_Hosix'] = idHosix;
    data['designation'] = designation;
    data['prescripteur'] = prescripteur;
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    data['date'] = dateFormat.format(date);
    data['etat'] = etat;
    data['Id_P'] = idP;
    data['Id_S'] = idS;
    data['nom'] = nom;
    data['prenom'] = prenom;
    DateFormat dateFormat2 = DateFormat("yyyy-MM-dd");
    data['date_naissance'] = dateFormat2.format(date_naissance);
    data['sexe'] = sexe;
    return data;
  }
}
