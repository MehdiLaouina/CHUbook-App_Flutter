import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login_register/config.dart';
import 'package:login_register/models/login_request_model.dart';
import 'package:login_register/models/login_response_model.dart';
import 'package:login_register/models/orders_by_patient_model.dart';
import 'package:login_register/models/orders_by_service_model.dart';
import 'package:login_register/models/orders_model.dart';
import 'package:login_register/models/patient_model.dart';
import 'package:login_register/models/register_request_model.dart';
import 'package:login_register/models/register_response_model.dart';
import 'package:login_register/models/service_model.dart';
import 'package:login_register/services/shared_service.dart';

class APIService {
  static var client = http.Client();

  static Future<bool> login(LoginRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, Config.loginAPI);

    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));

    if (response.statusCode == 200) {
      //user succefully logged in
      await SharedService.setLoginDetails(loginResponseJson(response.body));
      return true;
    } else {
      return false;
    }
  }

  static Future<RegisterResponseModel> register(
      RegisterRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, Config.registerAPI);

    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));

    return registerResponseModel(response.body);
  }

  static Future<String> getUserProfile() async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Authorization': 'Basic ${loginDetails!.data.token}'
    };

    var url = Uri.http(Config.apiURL, Config.userProfileAPI);

    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      //user succefully logged in
      return response.body;
    } else {
      return "";
    }
  }

  Future<List<OrderModel>> getAllOrders() async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Authorization': 'Basic ${loginDetails!.data.token}',
      'content-Type': "application/json"
    };

    var url = Uri.http(Config.apiURL, Config.ordersAPI);

    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      //user succefully logged in
      return ordersFromJson(json.decode(response.body));
    } else {
      // ignore: deprecated_member_use
      return null as List<OrderModel>;
    }
  }

  Future<List<OrderByServiceModel>> getOrdersByService(query) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Authorization': 'Basic ${loginDetails!.data.token}',
      'content-Type': "application/json"
    };

    var url = Uri.http(Config.apiURL, Config.ordersByServiceAPI(query));

    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      //user succefully logged in
      return ordersSFromJson(json.decode(response.body));
    } else {
      // ignore: deprecated_member_use
      return null as List<OrderByServiceModel>;
    }
  }

  Future<List<OrderByPatientModel>> getOrderByPatient(query) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Authorization': 'Basic ${loginDetails!.data.token}',
      'content-Type': "application/json"
    };

    var url = Uri.http(Config.apiURL, Config.ordersByPatientAPI(query));

    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      //user succefully logged in
      return ordersPFromJson(json.decode(response.body));
    } else {
      // ignore: deprecated_member_use
      return null as List<OrderByPatientModel>;
    }
  }

  Future<List<OrderModel>> getOrderByEtat(query) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Authorization': 'Basic ${loginDetails!.data.token}',
      'content-Type': "application/json"
    };

    var url = Uri.http(Config.apiURL, Config.ordersByEtatAPI(query));

    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      //user succefully logged in
      return ordersFromJson(json.decode(response.body));
    } else {
      // ignore: deprecated_member_use
      return null as List<OrderModel>;
    }
  }

  Future<List<OrderModel>> getOrderById(id, token) async {
    Map<String, String> requestHeaders = {
      'Authorization': 'Basic $token',
      'content-Type': "application/json"
    };

    var url = Uri.http(Config.apiURL, Config.orderById(id));

    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      //user succefully logged in
      return ordersFromJson(json.decode(response.body));
    } else {
      // ignore: deprecated_member_use
      return null as List<OrderModel>;
    }
  }

  Future<List<PatientModel>> getPatientByOrder(idP, token) async {
    Map<String, String> requestHeaders = {
      'Authorization': 'Basic $token',
      'content-Type': "application/json"
    };

    var url = Uri.http(Config.apiURL, Config.patientByOrder(idP));

    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      //user succefully logged in
      return patientFromJson(json.decode(response.body));
    } else {
      // ignore: deprecated_member_use
      return null as List<PatientModel>;
    }
  }

  Future<List<ServiceModel>> getServiceByOrder(idS, token) async {
    Map<String, String> requestHeaders = {
      'Authorization': 'Basic $token',
      'content-Type': "application/json"
    };

    var url = Uri.http(Config.apiURL, Config.serviceByOrder(idS));

    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      //user succefully logged in
      return serviceFromJson(json.decode(response.body));
    } else {
      return null as List<ServiceModel>;
    }
  }

  Future<String> getToken() async {
    var loginDetails = await SharedService.loginDetails();
    return loginDetails!.data.token;
  }
}
