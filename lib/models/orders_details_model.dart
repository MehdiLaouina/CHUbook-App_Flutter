// ignore_for_file: non_constant_orderentifier_names, prefer_collection_literals

import 'package:login_register/models/orders_model.dart';
import 'package:login_register/models/patient_model.dart';
import 'package:login_register/models/service_model.dart';

List<OrderDetailsModel> ordersDetailsFromJson(dynamic str) =>
    List<OrderDetailsModel>.from(
        (str).map((x) => OrderDetailsModel.fromJson(x)));

class OrderDetailsModel {
  late OrderModel order;
  late PatientModel patient;
  late ServiceModel service;

  OrderDetailsModel(
      {required this.order, required this.patient, required this.service});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    OrderModel.fromJson(json);
    ServiceModel.fromJson(json);
    PatientModel.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data1 = new Map<String, dynamic>();
    Map<String, dynamic> data2 = new Map<String, dynamic>();
    Map<String, dynamic> data3 = new Map<String, dynamic>();
    data1 = order.toJson();
    data2 = patient.toJson();
    data3 = service.toJson();
    Map<String, dynamic> data = new Map<String, dynamic>();
    data.addAll(data1);
    data.addAll(data2);
    data.addAll(data3);
    return data;
  }
}
