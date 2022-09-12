// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:login_register/models/orders_model.dart';
import 'package:login_register/pages/base_page.dart';
import 'package:snippet_coder_utils/hex_color.dart';

import '../services/api_service.dart';
import '../widgets/search_widget.dart';
import 'orders_details_page.dart';

class OrderByEtat extends BasePage {
  const OrderByEtat({Key? key}) : super(key: key);

  @override
  _OrderByEtatState createState() => _OrderByEtatState();
}

class _OrderByEtatState extends BasePageState {
  List<OrderModel> orders = [];
  String query = '';
  Timer? debouncer;
  late APIService apiService = APIService();

  @override
  void initState() {
    super.initState();
    pageTitle = "Etat des ordonnances";
    init();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future init() async {
    final orders = await apiService.getAllOrders();

    setState(() => this.orders = orders);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor("#AEB6BF"),
          title: Text(pageTitle),
          centerTitle: true,
          titleSpacing: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                bottom: Radius.elliptical(
                    MediaQuery.of(context).size.width, 100.0)),
          ),
        ),
        body: Column(
          children: <Widget>[
            buildSearch(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: buildOrder(order),
                      );
                    }),
              ),
            ),
          ],
        ),
      );

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'etat d\'une ordonnance, Exemple : N | V',
        onChanged: searchOrder,
      );

  Future searchOrder(String query) async => debounce(() async {
        final orders = query == ""
            ? await apiService.getAllOrders()
            : await apiService.getOrderByEtat(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.orders = orders;
        });
      });
  Widget buildOrder(OrderModel order) {
    return Container(
      color: Colors.white,
      child: ListTile(
        leading: order.etat == "N"
            ? const Text("Non Validée")
            : const Text("Validée"),
        title: Text(order.designation),
        subtitle: Text(order.prescripteur),
        trailing: Text(order.date.toString().split(" ")[0]),
        focusColor: Colors.blue[300],
        contentPadding: const EdgeInsets.all(15),
        onTap: (() {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    OrderDetails(id: order.id, idP: order.idP, idS: order.idS)),
          );
        }),
      ),
    );
  }
}
