// ignore_for_file: non_constant_Identifier_names
import 'package:intl/intl.dart';

List<OrderByServiceModel> ordersSFromJson(dynamic str) =>
    List<OrderByServiceModel>.from(
        (str).map((x) => OrderByServiceModel.fromJson(x)));

class OrderByServiceModel {
  late int id;
  late int idHosix;
  late String designation;
  late String prescripteur;
  late DateTime date;
  late String etat;
  late int idP;
  late int idS;
  late String libelle;

  OrderByServiceModel({
    required this.id,
    required this.idHosix,
    required this.designation,
    required this.prescripteur,
    required this.date,
    required this.etat,
    required this.idP,
    required this.idS,
    required this.libelle,
  });

  OrderByServiceModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    idHosix = json['Id_Hosix'];
    designation = json['designation'];
    prescripteur = json['prescripteur'];
    date = DateTime.parse(json['date']);
    etat = json['etat'];
    idP = json['Id_P'];
    idS = json['Id_S'];
    libelle = json['libelle'];
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
    data['libelle'] = libelle;
    return data;
  }
}
