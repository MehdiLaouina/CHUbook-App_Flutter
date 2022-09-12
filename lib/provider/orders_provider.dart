// ignore_for_file: prefer_conditional_assignment

import 'package:flutter/cupertino.dart';
import 'package:login_register/models/orders_model.dart';
import 'package:login_register/services/api_service.dart';

class OrdersProvider with ChangeNotifier {
  late APIService _apiService;

  late List<OrderModel>? _ordersList;
  List<OrderModel>? get ordersList => _ordersList;
  double? get totalRecords => _ordersList?.length.toDouble();

  OrdersProvider() {
    _apiService = APIService();
    _ordersList = null;
  }

  resetStream() {
    _apiService = APIService();
    _ordersList = null;

    notifyListeners();
  }

  fetchOrders() async {
    List<OrderModel> ordersList = await _apiService.getAllOrders();

    if (_ordersList == null) {
      _ordersList = List<OrderModel>.empty(growable: true);
    }

    if (ordersList.isNotEmpty) {
      _ordersList = [];
      _ordersList?.addAll(ordersList);
    }

    notifyListeners();
  }
}
