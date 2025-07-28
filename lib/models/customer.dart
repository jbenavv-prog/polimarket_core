class Customer {
  final int customer_id;
  final String customer_name;
  final String customer_email;

  Customer({required this.customer_id, required this.customer_name, required this.customer_email});

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    customer_id: json['customer_id'] ?? 0,
    customer_name: json['customer_name'] ?? '',
    customer_email: json['customer_email'] ?? '',
  );
}