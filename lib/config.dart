// ignore_for_file: prefer_interpolation_to_compose_strings

class Config {
  static const String appName = "CHUbook app";
  static const String apiURL = "192.168.1.101:8080";
  static const String loginAPI = "/users/login";
  static const String registerAPI = "/users/register";
  static const String userProfileAPI = "/users/user-profile";
  static const String ordersAPI = "/api/orders";
  static String ordersByServiceAPI(query) {
    return "/api/orders_S/" + query;
  }

  static String ordersByPatientAPI(query) {
    return "/api/orders_P/" + query;
  }

  static String ordersByEtatAPI(char) {
    return "/api/orders_etat/" + char;
  }

  static String orderById(int id) {
    return "/api/order_Id/" + id.toString();
  }

  static String patientByOrder(int idP) {
    return "/api/patientByOrder/" + idP.toString();
  }

  static String serviceByOrder(int idS) {
    return "/api/serviceByOrder/" + idS.toString();
  }

  static const String orderAPI = "/api/order";
}
