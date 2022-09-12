import 'package:flutter/material.dart';
import 'package:login_register/services/shared_service.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);

  get id => null;

  get idP => null;

  get idS => null;

  @override
  State<BasePage> createState() => BasePageState();
}

class BasePageState<T extends BasePage> extends State<BasePage> {
  String pageTitle = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: _buildAppBar(),
      body: pageUI(),
    );
  }

  //this method to add a bar above the screen
  PreferredSizeWidget? _buildAppBar() {
    return AppBar(
      title: Text(pageTitle),
      elevation: 0,
      automaticallyImplyLeading: true,
      backgroundColor: HexColor("#AEB6BF"),
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
    );
  }

  Widget? pageUI() {
    return null;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
