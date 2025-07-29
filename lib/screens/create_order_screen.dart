import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/order.dart';
import '../services/api_service_products.dart';
import '../services/api_service_orders.dart';

class CreateOrderScreen extends StatefulWidget {
  const CreateOrderScreen({super.key});

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  List<Product> _products = [];
  Product? _selectedProduct;
  final TextEditingController _quantityController = TextEditingController();
  bool _isLoading = true;

  int _orderCount = 0;
  bool _isLoadingOrderCount = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
    _loadOrderCount();
  }

  Future<void> _loadProducts() async {
    try {
      final products = await ApiServiceProducts.fetchProducts();
      setState(() {
        _products = products;
        _selectedProduct = products.isNotEmpty ? products.first : null;
        _isLoading = false;
      });
    } catch (e) {
      print('Error al cargar productos: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadOrderCount() async {
    try {
      final count = await ApiServiceOrders.getOrderCount();
      setState(() {
        _orderCount = count;
        _isLoadingOrderCount = false;
      });
    } catch (e) {
      print('Error al obtener cantidad de órdenes: $e');
      setState(() {
        _isLoadingOrderCount = false;
      });
    }
  }

  Future<void> _submitOrder() async {
    final quantity = int.tryParse(_quantityController.text);
    if (_selectedProduct == null || quantity == null || quantity <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecciona un producto y una cantidad válida')),
      );
      return;
    }

    final order = Order(
      product_id: _selectedProduct!.product_id,
      quantity: quantity,
    );

    try {
      final success = await ApiServiceOrders.createOrder(order);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Orden creada con éxito')),
        );
        _quantityController.clear();
        await _loadOrderCount(); // actualizar contador al crear orden
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al crear la orden')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear Orden')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Texto con cantidad de órdenes
            _isLoadingOrderCount
                ? const CircularProgressIndicator()
                : Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: RichText(
                text: TextSpan(
                  text: 'Actualmente hay ',
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  children: [
                    TextSpan(
                      text: '$_orderCount',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(text: ' órdenes registradas.'),
                  ],
                ),
              ),
            ),
            const Text('Producto'),
            DropdownButton<Product>(
              isExpanded: true,
              value: _selectedProduct,
              onChanged: (Product? newValue) {
                setState(() {
                  _selectedProduct = newValue;
                });
              },
              items: _products.map((Product product) {
                return DropdownMenuItem<Product>(
                  value: product,
                  child: Text('${product.product_name} (Stock: ${product.product_stock})'),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _quantityController,
              decoration: const InputDecoration(
                labelText: 'Cantidad',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: _submitOrder,
                child: const Text('Enviar Pedido'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
