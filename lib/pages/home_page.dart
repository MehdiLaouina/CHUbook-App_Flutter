import 'package:flutter/material.dart';
import 'package:login_register/pages/ordersByService.dart';
import 'package:login_register/pages/ordersByPatient.dart';
import 'package:login_register/pages/ordersByEtat.dart';
import 'package:login_register/services/shared_service.dart';
import 'package:snippet_coder_utils/hex_color.dart';

import 'orders_list.dart';

class NavBarModel {
  String title;
  IconData icon;
  String color;

  NavBarModel(this.title, this.icon, this.color);
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<NavBarModel> titleList = [
    NavBarModel("Accueil", Icons.home, "#00B8E0"),
    NavBarModel("Service", Icons.medical_services, "#115A89"),
    NavBarModel("Patient", Icons.group, "#17117F"),
    NavBarModel("Etat", Icons.adjust, "#C604CA"),
  ];

  List<Widget> widgetList = [
    const OrdersList(),
    const OrderByService(),
    const OrderByPatient(),
    const OrderByEtat(),
  ];

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CHUBook App"),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                SharedService.logout(context);
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              )),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      backgroundColor: HexColor("#AEB6BF"),
      bottomNavigationBar: BottomNavigationBar(
        items: titleList.map((NavBarModel model) {
          return BottomNavigationBarItem(
            icon: Icon(
              model.icon,
              color: HexColor(model.color),
            ),
            label: model.title.toString(),
          );
        }).toList(),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        currentIndex: _index,
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
      ),
      body: widgetList[_index],
    );
  }
}
