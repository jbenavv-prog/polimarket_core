class Product {
  final int product_id;
  final String product_name;
  final int product_stock;

  Product({required this.product_id, required this.product_name, required this.product_stock});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    product_id: json['product_id'] ?? 0,
    product_name: json['product_name'] ?? '',
    product_stock: json['product_stock'] ?? '',
  );
}