class Order {
  final int product_id;
  final int quantity;

  Order({
    required this.product_id,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'product_id': product_id,
      'quantity': quantity,
    };
  }
}
