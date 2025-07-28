import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:polimarket_core/models/customer.dart';

class ApiServiceCustomers {
  static const String url = 'https://v6tq0zhcqa.execute-api.us-east-1.amazonaws.com/prod/customer';

  static Future<List<Customer>> fetchCustomers() async {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'User-Agent': 'FlutterApp/1.0',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Customer.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener Clientes');
    }
  }
}
