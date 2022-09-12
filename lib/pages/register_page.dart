import 'package:flutter/material.dart';
import 'package:login_register/models/register_request_model.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';

import '../config.dart';
import '../services/api_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isAPIcallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? nom;
  String? password;
  String? prenom;
  String? email;
  DateTime? lastLoginTime;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor("#AEB6BF"),
        body: ProgressHUD(
          inAsyncCall: isAPIcallProcess,
          opacity: 0.3,
          key: UniqueKey(),
          child: Form(
            key: globalFormKey,
            child: _registerUI(context),
          ),
        ),
      ),
    );
  }

  Widget _registerUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 5.2,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.white,
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100),
                bottomRight: Radius.circular(100),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/CHU_logo.png",
                    width: 250,
                    fit: BoxFit.contain,
                  ),
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 20,
              bottom: 30,
              top: 50,
            ),
            child: Text(
              "Register",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
          FormHelper.inputFieldWidget(context, "nom", "nom",
              prefixIcon: const Icon(
                Icons.person,
                color: Colors.white,
              ),
              showPrefixIcon: true, (onValidateVal) {
            if (onValidateVal.isEmpty) {
              return "nom can't be empty";
            }
            return null;
          }, (onSavedVal) {
            nom = onSavedVal;
          },
              borderFocusColor: Colors.white,
              borderColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white.withOpacity(0.7),
              borderRadius: 10),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: FormHelper.inputFieldWidget(
              context,
              "password",
              "Password",
              prefixIcon: const Icon(
                Icons.lock,
                color: Colors.white,
              ),
              showPrefixIcon: true,
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return "Password can't be empty";
                }
                return null;
              },
              (onSavedVal) {
                password = onSavedVal;
              },
              borderFocusColor: Colors.white,
              borderColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white.withOpacity(0.7),
              borderRadius: 10,
              obscureText: hidePassword,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    hidePassword = !hidePassword;
                  });
                },
                color: Colors.white.withOpacity(0.7),
                icon: Icon(
                  hidePassword ? Icons.visibility_off : Icons.visibility,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: FormHelper.inputFieldWidget(context, "email", "Email",
                prefixIcon: const Icon(
                  Icons.email,
                  color: Colors.white,
                ),
                showPrefixIcon: true, (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "Email can't be empty";
              }
              return null;
            }, (onSavedVal) {
              email = onSavedVal;
            },
                borderFocusColor: Colors.white,
                borderColor: Colors.white,
                textColor: Colors.white,
                hintColor: Colors.white.withOpacity(0.7),
                borderRadius: 10),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: FormHelper.inputFieldWidget(context, "prenom", "prenom",
                prefixIcon: const Icon(
                  Icons.person_pin_circle_sharp,
                  color: Colors.white,
                ),
                showPrefixIcon: true, (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "prenom can't be empty";
              }
              return null;
            }, (onSavedVal) {
              prenom = onSavedVal;
            },
                borderFocusColor: Colors.white,
                borderColor: Colors.white,
                textColor: Colors.white,
                hintColor: Colors.white.withOpacity(0.7),
                borderRadius: 10),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: FormHelper.submitButton(
              "Register",
              () {
                if (validateAndSave()) {
                  setState(() {
                    isAPIcallProcess = true;
                  });

                  RegisterRequestModel model = RegisterRequestModel(
                      nom: nom!,
                      password: password!,
                      email: email!,
                      prenom: prenom!);
                  APIService.register(model).then((response) {
                    setState(() {
                      isAPIcallProcess = false;
                    });
                    if (response.data != null) {
                      FormHelper.showSimpleAlertDialog(
                          context,
                          Config.appName,
                          "Registration Successfull. Please login to the account ",
                          "OK", () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/login', (route) => false);
                      });
                    } else {
                      FormHelper.showSimpleAlertDialog(
                          context, Config.appName, response.message, "OK", () {
                        Navigator.pop(context);
                      });
                    }
                  });
                }
              },
              btnColor: HexColor("#053041"),
              borderColor: Colors.white,
              txtColor: Colors.white,
              borderRadius: 10,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
