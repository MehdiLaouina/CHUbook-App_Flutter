// ignore_for_file: library_private_types_in_public_api, deprecated_member_use, prefer_collection_literals

import 'package:flutter/material.dart';
import 'package:login_register/pages/base_page.dart';
import 'package:login_register/pages/orders_details_page.dart';
import 'package:login_register/services/api_service.dart';
import 'package:snippet_coder_utils/hex_color.dart';

import '../models/orders_model.dart';

class OrdersList extends BasePage {
  const OrdersList({Key? key}) : super(key: key);

  @override
  _OrdersListState createState() => _OrdersListState();
}

class _OrdersListState extends BasePageState {
  late List<OrderModel> ordersList = [];
  late APIService apiService = APIService();

  @override
  //when navigate into a bar the pagetitle changes
  void initState() {
    super.initState();
    pageTitle = "Ordonnances";
  }

  @override
  Widget pageUI() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            color: HexColor("#AEB6BF"),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: orderListUI(),
            ),
          ),
        ],
      ),
    );
  }

  Future getData() async {
    final ordersList = await apiService.getAllOrders();
    this.ordersList = ordersList;
  }

  Widget orderListUI() {
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
      body: Card(
        child: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (ordersList.isEmpty) {
              return const Center(
                child: Text('Chargement'),
              );
            } else {
              return ListView.builder(
                itemBuilder: ((context, index) {
                  return ListTile(
                    leading: Column(
                      children: <Widget>[
                        TextButton(
                            child: const Text('Details'),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OrderDetails(
                                        id: ordersList[index].id,
                                        idP: ordersList[index].idP,
                                        idS: ordersList[index].idS)),
                              );
                            })
                      ],
                    ),
                    title: Text(ordersList[index].designation),
                    subtitle: Text(ordersList[index].prescripteur),
                    trailing:
                        Text(ordersList[index].date.toString().split(" ")[0]),
                    focusColor: Colors.blue[300],
                    contentPadding: const EdgeInsets.all(15),
                  );
                }),
                itemCount: 5,
              );
            }
          },
        ),
      ),
    );
  }
}
