import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:polimarket_core/models/order.dart';

class ApiServiceOrders{
  static const String url = 'https://v6tq0zhcqa.execute-api.us-east-1.amazonaws.com/prod/order';

  static Future<bool> createOrder(Order order) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'User-Agent': 'FlutterApp/1.0',
      },
      body: jsonEncode(order.toJson()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return true; // Orden creada con éxito
    } else {
      print('Error al crear la orden: ${response.body}');
      throw Exception('Error al crear la orden');
    }
  }

  static Future<int> getOrderCount() async {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'User-Agent': 'FlutterApp/1.0',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.length;
    } else {
      print('Error al obtener las órdenes: ${response.body}');
      throw Exception('Error al obtener cantidad de órdenes');
    }
  }
}
