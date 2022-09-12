List<ServiceModel> serviceFromJson(dynamic str) =>
    List<ServiceModel>.from((str).map((x) => ServiceModel.fromJson(x)));

class ServiceModel {
  late int idS;
  late String libelle;

  ServiceModel({required this.idS, required this.libelle});

  ServiceModel.fromJson(Map<String, dynamic> json) {
    idS = json['Id_S'];
    libelle = json['libelle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id_S'] = this.idS;
    data['libelle'] = this.libelle;
    return data;
  }
}
