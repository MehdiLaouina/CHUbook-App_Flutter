// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:login_register/models/patient_model.dart';
import 'package:login_register/models/service_model.dart';
import 'package:login_register/pages/base_page.dart';
import 'package:login_register/services/api_service.dart';
import 'package:snippet_coder_utils/hex_color.dart';

import '../models/orders_model.dart';

class OrderDetails extends BasePage {
  @override
  late int id;
  @override
  late int idP;
  @override
  late int idS;
  OrderDetails(
      {super.key, required this.id, required this.idP, required this.idS});

  @override
  OrderDetailsState createState() => OrderDetailsState();
}

class OrderDetailsState extends BasePageState {
  OrderModel? order;
  ServiceModel? service;
  PatientModel? patient;
  APIService? apiService = APIService();
  String? token;

  @override
  void initState() {
    super.initState();
    pageTitle = "Details du l'ordonnance";
  }

  Future getToken() async {
    final token = await apiService?.getToken();
    this.token = token;
  }

  Future getOrderData() async {
    if (order == null) {
      final order = await apiService?.getOrderById(widget.id, token);
      setState(() => this.order = order?.first);
    }
  }

  Future getPatientData() async {
    if (patient == null) {
      final patient = await apiService?.getPatientByOrder(widget.idP, token);
      this.patient = patient?.first;
    }
  }

  Future getserviceData() async {
    if (service == null) {
      final service = await apiService?.getServiceByOrder(widget.idS, token);
      this.service = service?.first;
    }
  }

  @override
  Widget pageUI() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#AEB6BF"),
        title: Text(pageTitle),
        centerTitle: true,
        titleSpacing: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
              bottom:
                  Radius.elliptical(MediaQuery.of(context).size.width, 100.0)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              color: HexColor("#AEB6BF"),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 1000,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: FutureBuilder(
                    future: getToken(),
                    builder: ((context, snapshot) {
                      if (token == null) {
                        return const Center(
                          child: Text('Chargement'),
                        );
                      } else {
                        return orderDetailsUI();
                      }
                    })),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget orderDetailsUI() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
            child: Center(
                child: Text(
              "Propriétés du l'ordonnance",
              style: TextStyle(
                fontSize: 20,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 2
                  ..color = HexColor("#AEB6BF"),
              ),
            )),
          ),
          FutureBuilder(
            future: getOrderData(),
            builder: (context, snapshot) {
              if (order == null) {
                return const Center(
                  child: Text('Chargement'),
                );
              } else {
                return ListView.builder(
                    itemCount: 1,
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Text("Id : ${order?.id}"),
                        title: Text(
                            "Date : ${order?.date.toString().split(".")[0]}"),
                        subtitle: Text("Id Hosix : ${order?.idHosix}"),
                        trailing: order?.etat.toString() == "N"
                            ? const Text("Non validée")
                            : const Text("Validée"),
                        focusColor: Colors.blue[300],
                        contentPadding: const EdgeInsets.all(15),
                      );
                    });
              }
            },
          ),
          const SizedBox(
            height: 1,
          ),
          FutureBuilder(
            builder: (context, snapshot) {
              if (order == null) {
                return const Center(
                  child: Text('Chargement'),
                );
              } else {
                return ListView.builder(
                    itemCount: 1,
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Text(
                            "Prescripteur :\n ${order?.prescripteur.toString()}"),
                        title: Text("Designation : \n ${order?.designation}"),
                        focusColor: Colors.blue[300],
                        contentPadding: const EdgeInsets.all(15),
                      );
                    });
              }
            },
          ),
          Divider(
            color: HexColor("#AEB6BF"),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 50,
            child: Center(
                child: Text(
              "Propriétés du service de l'ordonnance",
              style: TextStyle(
                fontSize: 20,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 2
                  ..color = HexColor("#AEB6BF"),
              ),
            )),
          ),
          FutureBuilder(
            future: getserviceData(),
            builder: (context, snapshot) {
              if (service == null) {
                return const Center(
                  child: Text('Chargement'),
                );
              } else {
                return ListView.builder(
                  itemCount: 1,
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: ((context, index) {
                    return ListTile(
                      dense: true,
                      contentPadding: const EdgeInsets.all(2),
                      leading: const Text("Service : "),
                      title: const Text("Libellé Service : "),
                      subtitle: Text(service?.libelle.toString() ??
                          "Libellé service non obtenue"),
                    );
                  }),
                );
              }
            },
          ),
          Divider(
            color: HexColor("#AEB6BF"),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 50,
            child: Center(
                child: Text(
              "Propriétés du patient de l'ordonnance",
              style: TextStyle(
                fontSize: 20,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 2
                  ..color = HexColor("#AEB6BF"),
              ),
            )),
          ),
          FutureBuilder(
            future: getPatientData(),
            builder: (context, snapshot) {
              if (patient == null) {
                return const Center(
                  child: Text('Chargement'),
                );
              } else {
                return ListView.builder(
                  itemCount: 1,
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: ((context, index) {
                    String? nomTitle = patient?.nom.toString();
                    String? prenomTitle = patient?.prenom.toString();
                    String? title = "$nomTitle $prenomTitle";
                    String? sexe = "Sexe : ${patient?.sexe}";
                    return ListTile(
                      dense: true,
                      contentPadding: const EdgeInsets.all(2),
                      leading: const Text("Patient : "),
                      title: Text(title),
                      subtitle: Text(sexe),
                      trailing: Text(
                          "date naissance : ${patient?.date_naissance.toString().split(" ")[0]}"),
                    );
                  }),
                );
              }
            },
          ),
        ],
      ),
    );
  }
/*
  //to check if it has an impact or not
  Widget listOrderItems() {
    return ListView.builder(
        itemCount: 1,
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return orderItems();
        });
  }

  Widget orderItems() => ListTile(
        leading:
            Text(order?.id.toString() ?? "L'identifiant ordonnance non obtenu"),
        title:
            Text(order?.date.toString() ?? "date du l'ordonnance non obtenue"),
        subtitle: Text("Id Hosix : ${order?.idHosix}"),
        trailing: Text(order?.etat ?? "etat du l'ordonnance non obtenue"),
        focusColor: Colors.blue[300],
        contentPadding: const EdgeInsets.all(15),
      );

  Widget patientItems() => ListTile(
        dense: true,
        contentPadding: const EdgeInsets.all(2),
        leading: const Text("Patient : "),
        title: Text(orderDetails.patient.nom.toString() +
            orderDetails.patient.prenom.toString()),
        subtitle: Text("Sexe : ${orderDetails.patient.sexe}"),
        trailing: Text(orderDetails.patient.date_naissance.toString()),
      );

  Widget serviceItems() => ListTile(
        dense: true,
        contentPadding: const EdgeInsets.all(2),
        leading: const Text("Service : "),
        title: const Text("Libellé Service : "),
        subtitle: Text(orderDetails.service.libelle.toString()),
      );
  */
}
