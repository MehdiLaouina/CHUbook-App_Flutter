// ignore_for_file: non_constant_Identifier_names
import 'package:intl/intl.dart';

List<OrderModel> ordersFromJson(dynamic str) =>
    List<OrderModel>.from((str).map((x) => OrderModel.fromJson(x)));

class OrderModel {
  late int id;
  late int idHosix;
  late String designation;
  late String prescripteur;
  late DateTime date;
  late String etat;
  late int idP;
  late int idS;

  OrderModel(
      {required this.id,
      required this.idHosix,
      required this.designation,
      required this.prescripteur,
      required this.date,
      required this.etat,
      required this.idP,
      required this.idS});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    idHosix = json['Id_Hosix'];
    designation = json['designation'];
    prescripteur = json['prescripteur'];
    date = DateTime.parse(json['date']);
    etat = json['etat'];
    idP = json['Id_P'];
    idS = json['Id_S'];
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
    return data;
  }
}
